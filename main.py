import datetime
import logging
import os
from telegram import InlineKeyboardButton, ChatAction
from telegram.ext import Updater, CommandHandler, Filters, MessageHandler, ConversationHandler
from data_report import DataReport
from db_engine import DBHelper
from scheduler import Scheduler
from user_session import Session

# command list
# start_bot - none
# register - none
# list_item - none


db = DBHelper()
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
product_state_list = ["baik", "hilang", "dikembalikan", "rusak"]
session = Session()
logger = logging.getLogger(__name__)
RECEIVE_ITEM, RECEIVE_PHOTOS = range(1, 3)
scheduler = Scheduler()


def is_product_state_in_list(x: str) -> bool:
    x = x.strip()
    return any("{}".format(x) in s for s in product_state_list)


def start_bot(update, context):
    msg = "silahkan menggunakan sesuai dengan command yang tersedia jika anda pengguna baru harap melakukan registrasi " \
          "terlebih dahulu dengan menggunakan format /register nik;nama_lengkap"
    exam = "\nContoh: /register 152504308719;abdul hamid"
    context.bot.send_message(
        chat_id=update.effective_chat.id,
        text=msg + exam
    )


def register_handler(update, context):
    resp = update.message.text.replace('/register', '').strip().split(";")
    user_id = int(update.message.from_user.id)
    if len(resp) == 2:
        try:
            nik_resp = int(resp[0])
            full_name_resp = str(resp[1]).upper()
        except ValueError:
            context.bot.send_message(
                chat_id=update.effective_chat.id,
                text="nik yang dimasukkan bukan angka"
            )
            return
        if db.is_already_register(user_id, nik_resp):
            context.bot.send_message(
                chat_id=update.effective_chat.id,
                text="akun dan NIK anda telah didaftarkan sebelumnya"
            )
            return
        db.register(user_id, full_name_resp, nik_resp)
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="registrasi berhasil dilakukan"
        )
    else:
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="format yang anda masukkan salah, gunakan /register nik;nama_lengkap"
        )


def update_item_handler(update, context):
    user_id = int(update.message.from_user.id)
    if db.is_user_id_already_register(user_id):
        list_sn_related = db.get_sn_related(user_id)
        list_item = []
        for sn, pn in list_sn_related:
            list_item.append([InlineKeyboardButton(sn + " " + pn, callback_data=str(sn))])
        list_item.append([InlineKeyboardButton('cancel', callback_data='cancel')])
        print(list_item)
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="sesi update item diaktifkan, untuk keluar dari sesi update input command /cancel_update "
                 "\nupdate item dengan format\n serial_number ; status_produk",
        )
        return RECEIVE_ITEM
    else:
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="akun anda belum terdaftar"
        )
        return ConversationHandler.END


def receive_item_callback(update, context):
    user_id = int(update.message.from_user.id)
    msg = update.message.text.strip()
    if msg == "/cancel_update":
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="sesi update dibatalkan"
        )
        return ConversationHandler.END
    resp = msg.split(";")
    if len(resp) == 2:
        if db.is_sn_exist(resp[0].upper()):
            if is_product_state_in_list(resp[1].lower()):
                if session.is_user_active(user_id):
                    session.remove_user(user_id)
                session.add_user(user_id, resp[0], resp[1])
                context.bot.send_message(
                    chat_id=update.effective_chat.id,
                    text="update diterima, mohon upload foto kondisi barang terlebih dahulu"
                )
                return RECEIVE_PHOTOS
            else:
                context.bot.send_message(
                    chat_id=update.effective_chat.id,
                    text="kondisi produk tidak terdapat pada list, silahkan masukkan ulang, masukkan command "
                         "/cancel_update untuk membatalkan sesi update"
                )
                return RECEIVE_ITEM
        else:
            context.bot.send_message(
                chat_id=update.effective_chat.id,
                text="serial number tidak terdeteksi di sistem, silahkan masukkan ulang, masukkan command "
                     "/cancel_update untuk membatalkan sesi update"
            )
            return RECEIVE_ITEM
    else:
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="format input salah, silahkan masukkan ulang, masukkan command "
                 "/cancel_update untuk membatalkan sesi update"
        )
        return RECEIVE_ITEM


def my_item_handler(update, context):
    user_id = int(update.message.from_user.id)
    if db.is_user_id_already_register(user_id):
        text_resp = ""
        for sn, product_name, jenis_name, date_left, product_state, updated in db.get_related_item(user_id):
            date_update = datetime.datetime.strptime(str(updated), "%Y-%m-%d %H:%M:%S")
            end_date = date_update + datetime.timedelta(days=date_left)
            text_resp += "\nserial number: {} \nnama produk: {} \njenis produk: {} \ndeadline laporan: " \
                         "{} \nstatus produk: {} \nupdate terakhir: {} \n" \
                .format(sn, product_name, jenis_name, end_date, product_state, updated)
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text=text_resp
        )
    else:
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="akun anda belum terdaftar dalam sistem"
        )


def fallback_handler(update, context):
    logger.warning('Update "%s" caused error "%s"', update, context.error)


def receive_photo_callback(update, context):
    user_id = str(update.message.from_user.id)
    photo_id = update.message.photo[-1].file_id
    # save photo to local data base
    cur_dir = os.getcwd()
    user_path = os.path.join(cur_dir, "res", "img", str(datetime.datetime.today().strftime('%Y-%m-%d')), user_id)
    if not (os.path.exists(user_path)):
        os.makedirs(user_path, 0o777)
    photo_path = os.path.join(user_path, photo_id + ".jpg")
    context.bot.get_file(photo_id).download(photo_path)
    user_session = session.get_session(user_id)
    db.update_item_condition(user_id, user_session["sn"], user_session["product_state"], photo_path)
    session.remove_user(user_id)
    context.bot.send_message(
        chat_id=update.effective_chat.id,
        text="update item berhasil dilakukan, anda bisa melakukan update kembali menggunakan format yang sama,"
             " untuk mengakhir sesi update tekan command /cancel_update"
    )
    return RECEIVE_ITEM


def cancel_update(update, context):
    user_id = str(update.message.from_user.id)
    if session.is_user_active(user_id):
        session.remove_user(user_id)
    context.bot.send_message(
        chat_id=update.effective_chat.id,
        text="sesi update telah dinon-aktifkan"
    )
    return ConversationHandler.END


def subscribe_handler(update, context):
    chat_group_id = update.message.chat.id
    title_group = update.message.chat.title
    if title_group is None:
        title_group = update.message.from_user.username
    if db.is_already_reminder(chat_group_id):
        context.bot.send_message(
            chat_id=chat_group_id,
            text="group sudah berlangganan notifikasi reminder sebelumnya"
        )
    else:
        db.insert_reminder_groups(chat_group_id, title_group)
        context.bot.send_message(
            chat_id=chat_group_id,
            text="berhasil melakukan langganan notifikasi kepada " + title_group
        )


def turn_on_reminder_handler(update, context):
    if scheduler.is_on:
        scheduler.turn_off_reminder()
    if scheduler.turn_on_reminder(context):
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="berhasil menyalakan reminder"
        )


def turn_off_reminder(update, context):
    scheduler.turn_off_reminder()
    context.bot.send_message(
        chat_id=update.effective_chat.id,
        text="reminder dimatikan"
    )


def recap_recent_update_item(update, context):
    send_typing_state(update, context)
    df = DataReport.recap_as_dataframe(db.get_recap_recent_update())
    date_recap = datetime.datetime.today().strftime('%Y-%m-%d')
    file_name = 'rekap item tanggal {}.xlsx'.format(date_recap)
    df.to_excel(file_name, index=False)
    context.bot.send_document(
        chat_id=update.effective_chat.id,
        document=open(file_name, 'rb'),
        filename=file_name
    )


def get_visualize_state(update, context):
    send_typing_state(update, context)
    file_name = DataReport.visualize_by_product_state(db.get_products_group_by_state())
    context.bot.send_photo(
        chat_id=update.effective_chat.id,
        photo=open(file_name, 'rb')
    )


def unsubscribe_handler(update, context):
    chat_id = update.message.chat.id
    if not db.is_already_reminder(chat_id):
        context.bot.send_message(
            chat_id=chat_id,
            text="group belum berlangganan sebelumnya, anda dapat berlangganan melalui /subscribe"
        )
    else:
        db.remove_reminder_group(chat_id)
        context.bot.send_message(
            chat_id=chat_id,
            text="fitur notifikasi berlangganan berhasil dimatikan"
        )


def send_typing_state(update, context):
    context.bot.send_chat_action(
        chat_id=update.effective_chat.id,
        action=ChatAction.TYPING
    )


def track_record(update, context):
    send_typing_state(update, context)
    serial_number = update.message.text.replace('/track_record', '').strip().upper()
    pd_id = db.get_product_id(serial_number)
    if pd_id is None:
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="serial number tidak ditemukan"
        )
    else:
        track_records = db.get_track_record(pd_id)
        if not track_records:
            context.bot.send_message(
                chat_id=update.effective_chat.id,
                text="serial number ditemukan namun belum memiliki track record"
            )
        else:
            df = DataReport.recap_as_dataframe(track_records)
            date_recap = datetime.datetime.today().strftime('%Y-%m-%d')
            file_name = 'rekap track record {} tanggal {}.xlsx'.format(serial_number, date_recap)
            df.to_excel(file_name, index=False)
            context.bot.send_document(
                chat_id=update.effective_chat.id,
                document=open(file_name, 'rb'),
                filename=file_name
            )


def get_visualize_merk(update, context):
    send_typing_state(update, context)
    data_counts = db.get_count_merk_item()
    if not data_counts:
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="data merk tidak tidak ditemukan"
        )
    else:
        file_name = DataReport.visualize_count_item(data_counts, 'Merk', 'Rekap Merk')
        context.bot.send_photo(
            chat_id=update.effective_chat.id,
            photo=open(file_name, 'rb')
        )


def get_visualize_jenis(update, context):
    send_typing_state(update, context)
    data_counts = db.get_count_jenis_item()
    if not data_counts:
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="data jenis tidak tidak ditemukan"
        )
    else:
        file_name = DataReport.visualize_count_item(data_counts, 'Jenis', 'Rekap Jenis')
        context.bot.send_photo(
            chat_id=update.effective_chat.id,
            photo=open(file_name, 'rb')
        )


def seed_employees(update, context):
    user_id = int(update.message.from_user.id)
    nik = update.message.text.replace('/seed', '').strip()
    user_name = update.message.from_user.username
    if db.is_nik_already_seed(int(nik)):
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="nik tidak dapat di seed"
        )
    else:
        if db.is_already_register(int(user_id), int(nik)):
            context.bot.send_message(
                chat_id=update.effective_chat.id,
                text="nik dan user id telah didaftarkan sebelumnya"
            )
        else:
            db.seed_employee(int(user_id), user_name, int(nik))
            context.bot.send_message(
                chat_id=update.effective_chat.id,
                text="berhasil melakukan seed"
            )


def list_code_handler(update, context):
    list_merk = db.get_list_merk()
    list_jenis = db.get_list_jenis()
    text_resp = " === kondisi item === \nhilang, rusak, dikembalikan, baik"
    text_resp += "\n\n=== list kode merk === "
    text_resp += "\n code - merk"
    for merk in list_merk:
        text_resp += "\n{} - {}".format(merk[0], merk[1])
    text_resp += "\n\n=== list kode jenis === "
    text_resp += "\n code - jenis - durasi reminder"
    for jenis in list_jenis:
        text_resp += "\n{} - {} - {}".format(jenis[0], jenis[1], jenis[2])
    context.bot.send_message(
        chat_id=update.effective_chat.id,
        text=text_resp
    )


def add_jenis_handler(update, context):
    respon_message = update.message.text.replace('/add_jenis', '').split(";")
    if len(respon_message) == 2:
        if DataReport.is_number(respon_message[1]):
            db.add_jenis(respon_message[0].strip(), respon_message[1].strip())
            context.bot.send_message(
                chat_id=update.effective_chat.id,
                text="jenis berhasil ditambahkan"
            )
            return
    context.bot.send_message(
        chat_id=update.effective_chat.id,
        text="format yang anda masukkan salah pastikan format yang dimasukkan /add_jenis (spasi) "
             "(nama jenis);(durasi reminder) \nex: /add_jenis OPTICAL LISGHT SOURCE ; 6"
    )


def add_new_item(update, context):
    user_id = int(update.message.from_user.id)
    respon_message = update.message.text.replace('/add_item', '').split(";")
    if db.is_user_id_already_register(user_id):
        if len(respon_message) == 5:
            sn = str(respon_message[0]).strip().upper()
            pn = str(respon_message[1]).strip().upper()
            merk_id = respon_message[2].strip()
            jenis_id = respon_message[3].strip()
            product_stated = str(respon_message[4]).strip().lower()
            if DataReport.is_number(merk_id) and DataReport.is_number(jenis_id):
                merk_id = int(merk_id)
                jenis_id = int(jenis_id)
                if not db.is_sn_exist(sn):
                    list_id_m = db.get_id_merks()
                    list_id_j = db.get_id_jenises()
                    if (merk_id in list_id_m) and (jenis_id in list_id_j):
                        if is_product_state_in_list(product_stated):
                            user_id = db.get_user_id_by_telegram(user_id)
                            db.add_new_item(sn, pn, merk_id, jenis_id, product_stated, user_id)
                            context.bot.send_message(
                                chat_id=update.effective_chat.id,
                                text="penambahan item berhasil dilakukan"
                            )
                            return
                        else:
                            context.bot.send_message(
                                chat_id=update.effective_chat.id,
                                text="kondisi item tidak terdapat pada list lihat di /list_code"
                            )
                            return
                    else:
                        context.bot.send_message(
                            chat_id=update.effective_chat.id,
                            text="kode jenis atau kode merk tidak dikenali lihat di /list_code"
                        )
                        return
                else:
                    context.bot.send_message(
                        chat_id=update.effective_chat.id,
                        text="serial number sudah dipakai sebelumnya"
                    )
                    return
            else:
                context.bot.send_message(
                    chat_id=update.effective_chat.id,
                    text="pastikan kode merk dan jenis berupa angka lihat di /list_code"
                )
                return
        else:
            context.bot.send_message(
                chat_id=update.effective_chat.id,
                text="format yang dimasukkan salah pastikan format yang dimasukkan berupa \n"
                     " /add_item serial_number ; nama_item ; kode_merk ; kode_jenis ; kondisi_item"
            )
            return
    else:
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="user anda belum terdaftar dalam sistem"
        )
        return


def add_merk_handler(update, context):
    respon_message = str(update.message.text).replace('/add_merk', '').strip()
    if len(respon_message) == 0:
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="format yang anda masukkan salah pastikan format yang dimasukkan /add_merk (spasi) "
                 "(nama merk) \nex: /add_merk ALCATEX"
        )
        return
    db.add_merk(respon_message)
    context.bot.send_message(
        chat_id=update.effective_chat.id,
        text="merk berhasil ditambahkan"
    )


if __name__ == "__main__":
    print("Connecting to telegram server ...")
    up = Updater("1305082410:AAGGA_lYJJyHN-YeCYa_LqtWwJSwfA_qqRc", use_context=True)
    print("Connected to telegram server")
    print("Making conversation ...")
    conv_input_data = ConversationHandler(
        entry_points=[CommandHandler('update_item', update_item_handler)],
        allow_reentry=True,
        fallbacks=[CommandHandler('cancel_update', cancel_update)],
        states={
            RECEIVE_ITEM: [MessageHandler(Filters.text, receive_item_callback)],
            RECEIVE_PHOTOS: [MessageHandler(Filters.photo, receive_photo_callback)]
        }
    )
    # COMMAND UMUM
    up.dispatcher.add_handler(conv_input_data)
    up.dispatcher.add_handler(CommandHandler('start_bot', start_bot))
    up.dispatcher.add_handler(CommandHandler('register', register_handler))
    up.dispatcher.add_handler(CommandHandler('subscribe', subscribe_handler))
    up.dispatcher.add_handler(CommandHandler('unsubscribe', unsubscribe_handler))
    up.dispatcher.add_handler(CommandHandler('seed', seed_employees))
    up.dispatcher.add_handler(CommandHandler('my_item', my_item_handler))
    up.dispatcher.add_handler(CommandHandler('add_item', add_new_item))
    up.dispatcher.add_handler(CommandHandler('list_code', list_code_handler))
    up.dispatcher.add_handler(CommandHandler('cancel_update', cancel_update))
    # COMMAND SPECIAL
    up.dispatcher.add_handler(CommandHandler('track_record', track_record))
    up.dispatcher.add_handler(CommandHandler('recap_recent_item', recap_recent_update_item))
    up.dispatcher.add_handler(CommandHandler('turn_on_reminder', turn_on_reminder_handler))
    up.dispatcher.add_handler(CommandHandler('turn_off_reminder', turn_off_reminder))
    up.dispatcher.add_handler(CommandHandler('visualize_state', get_visualize_state))
    up.dispatcher.add_handler(CommandHandler('visualize_merk', get_visualize_merk))
    up.dispatcher.add_handler(CommandHandler('visualize_jenis', get_visualize_jenis))
    up.dispatcher.add_handler(CommandHandler('add_merk', add_merk_handler))
    up.dispatcher.add_handler(CommandHandler('add_jenis', add_jenis_handler))
    print("Making conversation done")
    up.start_polling()
    print("Chatbot already to use")
    up.idle()