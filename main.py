import os
import logging
import re
import sys, getopt
from telegram import InlineKeyboardMarkup, InlineKeyboardButton, ParseMode, ChatAction
from telegram.ext import Updater, CommandHandler, Filters, MessageHandler, ConversationHandler, CallbackQueryHandler
from db_engine import DBHelper
from datetime import datetime

# command list
# start_bot - none
# register - none
# list_item - none


db = DBHelper()
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
logger = logging.getLogger(__name__)


def start_bot(update, context):
    msg = "Silahkan menggunakan sesuai dengan command yang tersedia jika anda pengguna baru harap melakukan registrasi " \
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


def my_item_handler(update, context):
    user_id = int(update.message.from_user.id)
    if db.is_user_id_already_register(user_id):
        text_resp = ""
        for sn, product_name, jenis_name, date_left, product_state, updated in db.get_related_item(user_id):
            text_resp += "\nserial number: {} \nnama produk: {} \njenis produk: {} \ndurasi: " \
                         "{} hari \nstatus produk: {} \nupdate terakhir: {} \n"\
                .format(sn, product_name, jenis_name, date_left, product_state, updated)
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


if __name__ == "__main__":
    print("Connecting to telegram server ...")
    up = Updater("1305082410:AAGGA_lYJJyHN-YeCYa_LqtWwJSwfA_qqRc", use_context=True)
    print("Connected to telegram server")
    print("Making conversation ...")
    conv = ConversationHandler(
        entry_points=[CommandHandler('start_bot', start_bot)],
        allow_reentry=True,
        fallbacks=[
            # CommandHandler('code_csv', code_csv)
        ],
        states={

        }
    )
    # up.dispatcher.add_error_handler(fallback_handler)
    up.dispatcher.add_handler(CommandHandler('start_bot', start_bot))
    up.dispatcher.add_handler(CommandHandler('register', register_handler))
    up.dispatcher.add_handler(CommandHandler('list_item', my_item_handler))
    print("Making conversation done")
    up.start_polling()
    print("Chatbot already to use")
    up.idle()
