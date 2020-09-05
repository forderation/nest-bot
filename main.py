import datetime
import logging
import os

from telegram import InlineKeyboardButton
from telegram.ext import Updater, CommandHandler, Filters, MessageHandler, ConversationHandler

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
product_state_list = ["baik", "hilang", "dikembalikan"]
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
            text="format yang anda masukkan salah"
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
    print(update)
    if db.is_already_reminder(chat_group_id):
        context.bot.send_message(
            chat_id=chat_group_id,
            text="group sudah berlangganan notifikasi reminder sebelumnya"
        )
    else:
        db.insert_reminder_groups(chat_group_id, title_group)
        context.bot.send_message(
            chat_id=chat_group_id,
            text="berhasil melakukan langganan notifikasi kepada grup " + title_group
        )


def turn_on_reminder_handler(update, context):
    if scheduler.turn_on_reminder(context):
        context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="berhasil menyalakan reminder"
        )


def turn_off_reminder(update, context):
    pass


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
    # up.dispatcher.add_error_handler(fallback_handler)
    up.dispatcher.add_handler(conv_input_data)
    up.dispatcher.add_handler(CommandHandler('start_bot', start_bot))
    up.dispatcher.add_handler(CommandHandler('register', register_handler))
    up.dispatcher.add_handler(CommandHandler('turn_on_reminder', turn_on_reminder_handler))
    up.dispatcher.add_handler(CommandHandler('turn_off_reminder', turn_off_reminder))
    up.dispatcher.add_handler(CommandHandler('subscribe', subscribe_handler))
    up.dispatcher.add_handler(CommandHandler('list_item', my_item_handler))
    up.dispatcher.add_handler(CommandHandler('cancel_update', cancel_update))
    print("Making conversation done")
    up.start_polling()
    print("Chatbot already to use")
    up.idle()
