import datetime
import matplotlib.pyplot as plt
import pandas as pd
from pandas import DataFrame
import seaborn as sns


class DataReport:

    @staticmethod
    def recap_as_dataframe(data_report) -> DataFrame:
        df = pd.DataFrame(data_report,
                          columns=['serial number', 'nama item', 'merk item', 'jenis item', 'kondisi item', 'pemegang',
                                   'tanggal laporan terakhir', 'lokasi gambar'])
        df['kondisi item'] = df['kondisi item'].apply(lambda x: str(x).replace("_", " ").upper())
        return df

    @staticmethod
    def visualize_by_product_state(product_state):
        df = pd.DataFrame(product_state,
                          columns=['counts', 'product_state'])
        df['product_state'] = df['product_state'].apply(lambda x: str(x).replace("_", " ").upper())
        sns.barplot(x=df['product_state'], y=df['counts'])
        plt.xlabel("Kondisi Item")
        plt.ylabel("Jumlah Item")
        date_recap = datetime.datetime.today().strftime('%Y-%m-%d')
        plt.title("Rekap per tanggal {}".format(date_recap))
        file_name = "product state {}.png".format(date_recap)
        plt.savefig(file_name)
        return file_name

    @staticmethod
    def visualize_count_item(data_counts, x_label: str, header: str):
        df = pd.DataFrame(data_counts,
                          columns=[x_label, 'counts'])
        df[x_label] = df[x_label].apply(lambda x: str(x).replace("_", " ").upper())
        plt.bar(df[x_label], df['counts'])
        sns.barplot(x=df[x_label], y=df['counts'])
        plt.xlabel(x_label)
        plt.ylabel("Jumlah")
        date_recap = datetime.datetime.today().strftime('%Y-%m-%d')
        plt.title("{}, per tanggal {}".format(header, date_recap))
        file_name = "jumlah item by merk {}.png".format(date_recap)
        plt.savefig(file_name)
        return file_name

    @staticmethod
    def is_number(num) -> bool:
        try:
            int(num)
            return True
        except ValueError:
            return False
