from apscheduler.schedulers.background import BackgroundScheduler
import datetime

from db_engine import DBHelper, ProductState


class Scheduler:

    def __init__(self):
        self.scheduler = BackgroundScheduler()
        self.id_job = 'nest-bot-reminders'
        self.db = None
        self.context = None

    def turn_on_reminder(self, context_bot) -> bool:
        self.db = DBHelper()
        self.context = context_bot
        self.db.build_connection()
        self.scheduler.add_job(self.__do_remind, 'interval', hours=10, id=self.id_job, replace_existing=True)
        self.scheduler.start()
        return True

    def __do_remind(self):
        self.__update_item_state()
        self.__broadcast_remind()

    def __broadcast_remind(self):
        text_remind = "=== REMINDER ===" \
                      "\n nomor seri | nama item | jenis | status item | terakhir update | pemegang"
        for serial, product_name, jenis, product_state, update, employee_name in self.db.get_item_to_remind():
            text_remind += "\n{} | {} | {} | {} | {} | {}".format(serial, product_name, jenis, product_state, update,
                                                                  employee_name)
        list_to_reminds = self.db.get_reminder_groups()
        for id_g, chat_groups, title_groups in list_to_reminds:
            self.context.bot.send_message(
                chat_id=chat_groups,
                text=text_remind
            )

    def __update_item_state(self):
        list_to_remind = self.db.get_item_to_update()
        list_update_remind = []
        for id_ps, duration, updated in list_to_remind:
            date_update = datetime.datetime.strptime(str(updated), "%Y-%m-%d %H:%M:%S")
            end_date = date_update + datetime.timedelta(days=duration)
            time_since_insertion = datetime.datetime.now() - end_date
            if time_since_insertion.days > 1:
                list_update_remind.append([id_ps, ProductState.BELUM_MELAPORKAN.value])
        self.db.update_item_state(list_update_remind)

    def turn_off_reminder(self):
        self.scheduler.remove_job(self.id_job)
