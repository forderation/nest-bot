from enum import Enum
from sqlite3.dbapi2 import Cursor
import mysql.connector as connector
from pypika import Table, Query
from pypika.enums import Boolean as BoolSql, Order
from pypika.functions import Count


class ApproveState(Enum):
    APPROVED = "approved"
    DISAGREE = "disagree"
    WAITING = "waiting"


class ProductState(Enum):
    BAIK = "baik"
    HILANG = "hilang"
    BELUM_MELAPORKAN = "belum_melaporkan"
    DIKEMBALIKAN = "dikembalikan"
    RUSAK = "rusak"


class DBHelper:

    def __init__(self, dbname="nest-bot-dev"):
        self.dbname = dbname
        self.db = None
        self.TABLE_EMPLOYEES = Table('employees')
        self.TABLE_JENIS_PRODUCTS = Table('jenis_products')
        self.TABLE_MERK_PRODUCTS = Table('merk_products')
        self.TABLE_POSITION_PRODUCTS = Table('position_products')
        self.TABLE_REMINDER_GROUPS = Table('reminder_groups')
        self.TABLE_PRODUCTS = Table('products')
        self.NULL = "NULL"
        self.build_connection()

    def build_connection(self):
        while True:
            try:
                self.db = connector.connect(
                    host="localhost",
                    user="root",
                    passwd="",
                    database=self.dbname
                )
                print("Connected with database")
                break
            except connector.errors.InterfaceError:
                print("Connection error, try to connecting again")

    def register(self, user_id, full_name, nik):
        cursor = self.db.cursor(buffered=True)
        query = Query.into(self.TABLE_EMPLOYEES) \
            .columns(self.TABLE_EMPLOYEES.full_name, self.TABLE_EMPLOYEES.telegram_user_id, self.TABLE_EMPLOYEES.nik) \
            .insert(full_name, user_id, nik)
        print(query.get_sql(quote_char=None))
        cursor.execute(query.get_sql(quote_char=None))
        self.db.commit()

    def is_already_register(self, user_id: int, nik: int) -> bool:
        cursor = self.db.cursor(buffered=True)
        query = Query.from_(self.TABLE_EMPLOYEES).select(self.TABLE_EMPLOYEES.star).where(
            (self.TABLE_EMPLOYEES.telegram_user_id == user_id) &
            (self.TABLE_EMPLOYEES.nik == nik)
        )
        cursor.execute(query.get_sql(quote_char=None))
        if cursor.fetchone() is None:
            return False
        else:
            return True

    def is_nik_already_seed(self, nik):
        cursor = self.db.cursor(buffered=True)
        query = Query.from_(self.TABLE_EMPLOYEES).select(self.TABLE_EMPLOYEES.telegram_user_id).where(
            (self.TABLE_EMPLOYEES.nik == nik)
        )
        cursor.execute(query.get_sql(quote_char=None))
        if cursor.fetchone() is None:
            return True
        else:
            return False

    def is_user_id_already_register(self, user_id: int) -> bool:
        cursor = self.db.cursor(buffered=True)
        query = Query.from_(self.TABLE_EMPLOYEES).select(self.TABLE_EMPLOYEES.star).where(
            self.TABLE_EMPLOYEES.telegram_user_id == user_id
        )
        cursor.execute(query.get_sql(quote_char=None))
        if cursor.fetchone() is None:
            return False
        else:
            return True

    def get_employees_id(self, user_id: int) -> int:
        cursor = self.db.cursor(buffered=True)
        query = Query.from_(self.TABLE_EMPLOYEES).select(self.TABLE_EMPLOYEES.id).where(
            self.TABLE_EMPLOYEES.telegram_user_id == user_id
        )
        cursor.execute(query.get_sql(quote_char=None))
        list_convert = list(cursor.fetchone())
        return list_convert[0]

    def get_sn_related(self, user_id: int):
        cursor = self.db.cursor(buffered=True)
        query = Query.from_(self.TABLE_POSITION_PRODUCTS) \
            .join(self.TABLE_PRODUCTS).on(self.TABLE_PRODUCTS.id == self.TABLE_POSITION_PRODUCTS.product_id) \
            .join(self.TABLE_JENIS_PRODUCTS).on(self.TABLE_JENIS_PRODUCTS.id == self.TABLE_PRODUCTS.jenis_id) \
            .select(
            self.TABLE_PRODUCTS.serial_number, self.TABLE_PRODUCTS.product_name
        ).where(
            (self.TABLE_POSITION_PRODUCTS.employee_id == self.get_employees_id(user_id)) &
            (self.TABLE_POSITION_PRODUCTS.product_state != ProductState.DIKEMBALIKAN.value) &
            (self.TABLE_POSITION_PRODUCTS.new_update == BoolSql.true)
        )
        cursor.execute(query.get_sql(quote_char=None))
        return cursor.fetchall()

    def is_sn_exist(self, sn: str) -> bool:
        cursor = self.db.cursor(buffered=True)
        query = Query.from_(self.TABLE_PRODUCTS).select(self.TABLE_PRODUCTS.star).where(
            self.TABLE_PRODUCTS.serial_number == sn
        )
        cursor.execute(query.get_sql(quote_char=None))
        if cursor.fetchone() is None:
            return False
        else:
            return True

    def get_related_item(self, user_id: int) -> tuple:
        cursor = self.db.cursor(buffered=True)
        query = Query.from_(self.TABLE_POSITION_PRODUCTS) \
            .join(self.TABLE_PRODUCTS).on(self.TABLE_PRODUCTS.id == self.TABLE_POSITION_PRODUCTS.product_id) \
            .join(self.TABLE_JENIS_PRODUCTS).on(self.TABLE_JENIS_PRODUCTS.id == self.TABLE_PRODUCTS.jenis_id) \
            .select(
            self.TABLE_PRODUCTS.serial_number,
            self.TABLE_PRODUCTS.product_name,
            self.TABLE_JENIS_PRODUCTS.jenis_name,
            self.TABLE_JENIS_PRODUCTS.reminder,
            self.TABLE_POSITION_PRODUCTS.product_state,
            self.TABLE_POSITION_PRODUCTS.updated_at
        ).where(
            (self.TABLE_POSITION_PRODUCTS.employee_id == self.get_employees_id(user_id)) &
            (self.TABLE_POSITION_PRODUCTS.product_state != ProductState.DIKEMBALIKAN.value) &
            (self.TABLE_POSITION_PRODUCTS.new_update == BoolSql.true)
        )
        cursor.execute(query.get_sql(quote_char=None))
        return cursor.fetchall()

    def __get_foreign_position_products(self, user_id, sn):
        cursor = self.db.cursor(buffered=True)
        q = Query.from_(self.TABLE_EMPLOYEES).select(self.TABLE_EMPLOYEES.id) \
            .where(self.TABLE_EMPLOYEES.telegram_user_id == user_id)
        cursor.execute(q.get_sql(quote_char=None))
        employee_id = list(cursor.fetchone())[0]
        cursor = self.db.cursor(buffered=True)
        q = Query.from_(self.TABLE_PRODUCTS).select(self.TABLE_PRODUCTS.id) \
            .where(self.TABLE_PRODUCTS.serial_number == sn)
        cursor.execute(q.get_sql(quote_char=None))
        products_id = list(cursor.fetchone())[0]
        return employee_id, products_id

    def get_new_cursor(self) -> Cursor:
        return self.db.cursor(buffered=True)

    def update_item_condition(self, user_id, sn, product_state, photo_path):
        photo_path = photo_path.replace("\\", '/')
        cursor = self.db.cursor(buffered=True)
        employee_id, products_id = self.__get_foreign_position_products(user_id, sn)
        q = Query.update(self.TABLE_POSITION_PRODUCTS).set(
            self.TABLE_POSITION_PRODUCTS.new_update, BoolSql.false
        ) \
            .where((self.TABLE_POSITION_PRODUCTS.product_id == products_id) &
                   (self.TABLE_POSITION_PRODUCTS.employee_id == employee_id) &
                   (self.TABLE_POSITION_PRODUCTS.new_update == BoolSql.true)
                   )
        cursor.execute(q.get_sql(quote_char=None))
        self.db.commit()
        cursor = self.db.cursor(buffered=True)
        q = Query.into(self.TABLE_POSITION_PRODUCTS).columns(
            self.TABLE_POSITION_PRODUCTS.new_update, self.TABLE_POSITION_PRODUCTS.picture_loc,
            self.TABLE_POSITION_PRODUCTS.product_id, self.TABLE_POSITION_PRODUCTS.product_state,
            self.TABLE_POSITION_PRODUCTS.employee_id
        ).insert(BoolSql.true, photo_path, products_id, product_state, employee_id)
        cursor.execute(q.get_sql(quote_char=None))
        self.db.commit()

    def insert_reminder_groups(self, chat_id, chat_name):
        cursor = self.get_new_cursor()
        q = Query.into(self.TABLE_REMINDER_GROUPS).columns(
            self.TABLE_REMINDER_GROUPS.group_id, self.TABLE_REMINDER_GROUPS.last_known_group_name
        ).insert(int(chat_id), str(chat_name))
        cursor.execute(q.get_sql(quote_char=None))
        self.db.commit()

    def seed_employee(self, user_id, username, nik):
        cursor = self.get_new_cursor()
        q = Query.update(self.TABLE_EMPLOYEES).set(
            self.TABLE_EMPLOYEES.telegram_user_id, user_id
        ).set(
            self.TABLE_EMPLOYEES.telegram_user_name, username
        ).where(self.TABLE_EMPLOYEES.nik == nik)
        cursor.execute(q.get_sql(quote_char=None))
        self.db.commit()

    def is_already_reminder(self, chat_id):
        cursor = self.get_new_cursor()
        q = Query.from_(self.TABLE_REMINDER_GROUPS).select(self.TABLE_REMINDER_GROUPS.star).where(
            self.TABLE_REMINDER_GROUPS.group_id == int(chat_id)
        )
        cursor.execute(q.get_sql(quote_char=None))
        if cursor.fetchone() is None:
            return False
        else:
            return True

    def get_reminder_groups(self):
        cursor = self.get_new_cursor()
        q = Query.from_(self.TABLE_REMINDER_GROUPS).select(self.TABLE_REMINDER_GROUPS.star)
        cursor.execute(q.get_sql(quote_char=None))
        return list(cursor.fetchall())

    def get_item_to_remind(self):
        cursor = self.get_new_cursor()
        q1 = Query.from_(self.TABLE_POSITION_PRODUCTS) \
            .join(self.TABLE_PRODUCTS).on(self.TABLE_PRODUCTS.id == self.TABLE_POSITION_PRODUCTS.product_id) \
            .join(self.TABLE_JENIS_PRODUCTS).on(self.TABLE_JENIS_PRODUCTS.id == self.TABLE_PRODUCTS.jenis_id) \
            .join(self.TABLE_EMPLOYEES).on(self.TABLE_EMPLOYEES.id == self.TABLE_POSITION_PRODUCTS.employee_id) \
            .select(
            self.TABLE_PRODUCTS.serial_number,
            self.TABLE_PRODUCTS.product_name,
            self.TABLE_JENIS_PRODUCTS.jenis_name,
            self.TABLE_POSITION_PRODUCTS.product_state,
            self.TABLE_POSITION_PRODUCTS.updated_at,
            self.TABLE_EMPLOYEES.full_name
        ).where(
            (self.TABLE_POSITION_PRODUCTS.product_state == ProductState.BELUM_MELAPORKAN.value) &
            (self.TABLE_POSITION_PRODUCTS.new_update == BoolSql.true)
        )
        cursor.execute(q1.get_sql(quote_char=None))
        return list(cursor.fetchall())

    def get_item_to_update(self):
        cursor = self.get_new_cursor()
        q1 = Query.from_(self.TABLE_POSITION_PRODUCTS) \
            .join(self.TABLE_PRODUCTS).on(self.TABLE_PRODUCTS.id == self.TABLE_POSITION_PRODUCTS.product_id) \
            .join(self.TABLE_JENIS_PRODUCTS).on(self.TABLE_JENIS_PRODUCTS.id == self.TABLE_PRODUCTS.jenis_id) \
            .select(
            self.TABLE_POSITION_PRODUCTS.id,
            self.TABLE_JENIS_PRODUCTS.reminder,
            self.TABLE_POSITION_PRODUCTS.product_state,
            self.TABLE_POSITION_PRODUCTS.updated_at
        ).where(
            (self.TABLE_POSITION_PRODUCTS.product_state != ProductState.BELUM_MELAPORKAN.value) &
            (self.TABLE_POSITION_PRODUCTS.new_update == BoolSql.true)
        )
        cursor.execute(q1.get_sql(quote_char=None))
        return list(cursor.fetchall())

    def update_item_state(self, list_update_remind):
        for item in list_update_remind:
            cursor = self.get_new_cursor()
            id_ps = item[0]
            state = item[1]
            q = Query.update(self.TABLE_POSITION_PRODUCTS).set(
                self.TABLE_POSITION_PRODUCTS.product_state, state
            ).where(self.TABLE_POSITION_PRODUCTS.id == id_ps)
            cursor.execute(q.get_sql(quote_char=None))
            self.db.commit()

    def remove_reminder_group(self, chat_id):
        cursor = self.get_new_cursor()
        q = Query.from_(self.TABLE_REMINDER_GROUPS).delete().where(
            self.TABLE_REMINDER_GROUPS.group_id == int(chat_id)
        )
        cursor.execute(q.get_sql(quote_char=None))
        self.db.commit()

    def get_recap_recent_update(self):
        cursor = self.get_new_cursor()
        q1 = Query.from_(self.TABLE_POSITION_PRODUCTS) \
            .join(self.TABLE_PRODUCTS).on(self.TABLE_PRODUCTS.id == self.TABLE_POSITION_PRODUCTS.product_id) \
            .join(self.TABLE_JENIS_PRODUCTS).on(self.TABLE_JENIS_PRODUCTS.id == self.TABLE_PRODUCTS.jenis_id) \
            .join(self.TABLE_EMPLOYEES).on(self.TABLE_EMPLOYEES.id == self.TABLE_POSITION_PRODUCTS.employee_id) \
            .join(self.TABLE_MERK_PRODUCTS).on(self.TABLE_PRODUCTS.merk_id == self.TABLE_MERK_PRODUCTS.id) \
            .select(
            self.TABLE_PRODUCTS.serial_number,
            self.TABLE_PRODUCTS.product_name,
            self.TABLE_MERK_PRODUCTS.merk_name,
            self.TABLE_JENIS_PRODUCTS.jenis_name,
            self.TABLE_POSITION_PRODUCTS.product_state,
            self.TABLE_EMPLOYEES.full_name,
            self.TABLE_POSITION_PRODUCTS.updated_at,
            self.TABLE_POSITION_PRODUCTS.picture_loc
        ).where(
            (self.TABLE_POSITION_PRODUCTS.new_update == BoolSql.true)
        )
        cursor.execute(q1.get_sql(quote_char=None))
        return list(cursor.fetchall())

    def get_products_group_by_state(self):
        cursor = self.get_new_cursor()
        q1 = Query.from_(self.TABLE_POSITION_PRODUCTS).where(
            (self.TABLE_POSITION_PRODUCTS.new_update == BoolSql.true)
        ).groupby(self.TABLE_POSITION_PRODUCTS.product_state).select(Count(self.TABLE_PRODUCTS.id),
                                                                     self.TABLE_PRODUCTS.product_state)
        cursor.execute(q1.get_sql(quote_char=None))
        return list(cursor.fetchall())

    def get_track_record(self, product_id):
        cursor = self.get_new_cursor()
        q1 = Query.from_(self.TABLE_POSITION_PRODUCTS) \
            .join(self.TABLE_PRODUCTS).on(self.TABLE_PRODUCTS.id == self.TABLE_POSITION_PRODUCTS.product_id) \
            .join(self.TABLE_JENIS_PRODUCTS).on(self.TABLE_JENIS_PRODUCTS.id == self.TABLE_PRODUCTS.jenis_id) \
            .join(self.TABLE_EMPLOYEES).on(self.TABLE_EMPLOYEES.id == self.TABLE_POSITION_PRODUCTS.employee_id) \
            .join(self.TABLE_MERK_PRODUCTS).on(self.TABLE_PRODUCTS.merk_id == self.TABLE_MERK_PRODUCTS.id) \
            .select(
            self.TABLE_PRODUCTS.serial_number,
            self.TABLE_PRODUCTS.product_name,
            self.TABLE_MERK_PRODUCTS.merk_name,
            self.TABLE_JENIS_PRODUCTS.jenis_name,
            self.TABLE_POSITION_PRODUCTS.product_state,
            self.TABLE_EMPLOYEES.full_name,
            self.TABLE_POSITION_PRODUCTS.updated_at,
            self.TABLE_POSITION_PRODUCTS.picture_loc) \
            .where(self.TABLE_POSITION_PRODUCTS.product_id == product_id) \
            .orderby(self.TABLE_POSITION_PRODUCTS.updated_at, order=Order.desc)
        cursor.execute(q1.get_sql(quote_char=None))
        return list(cursor.fetchall())

    def get_product_id(self, serial_number: str):
        cursor = self.get_new_cursor()
        q1 = Query.from_(self.TABLE_PRODUCTS).select(self.TABLE_PRODUCTS.id) \
            .where(self.TABLE_PRODUCTS.serial_number == serial_number.upper().strip())
        cursor.execute(q1.get_sql(quote_char=None))
        return cursor.fetchone()

    def get_count_merk_item(self):
        cursor = self.get_new_cursor()
        q = Query.from_(self.TABLE_PRODUCTS).join(self.TABLE_MERK_PRODUCTS) \
            .on(self.TABLE_PRODUCTS.merk_id == self.TABLE_MERK_PRODUCTS.id) \
            .groupby(self.TABLE_PRODUCTS.merk_id).select(
            self.TABLE_MERK_PRODUCTS.merk_name,
            Count(self.TABLE_PRODUCTS.id))
        cursor.execute(q.get_sql(quote_char=None))
        return cursor.fetchall()

    def get_count_jenis_item(self):
        cursor = self.get_new_cursor()
        q = Query.from_(self.TABLE_PRODUCTS).join(self.TABLE_JENIS_PRODUCTS) \
            .on(self.TABLE_PRODUCTS.jenis_id == self.TABLE_JENIS_PRODUCTS.id) \
            .groupby(self.TABLE_PRODUCTS.jenis_id).select(
            self.TABLE_JENIS_PRODUCTS.jenis_name,
            Count(self.TABLE_PRODUCTS.id))
        cursor.execute(q.get_sql(quote_char=None))
        return cursor.fetchall()
