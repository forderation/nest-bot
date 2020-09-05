import datetime
import matplotlib.pyplot as plt
import pandas as pd
from pandas import DataFrame


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
        plt.style.use('ggplot')
        df = pd.DataFrame(product_state,
                          columns=['count', 'product_state'])
        df['product_state'] = df['product_state'].apply(lambda x: str(x).replace("_", " ").upper())
        plt.bar(df['product_state'], df['count'])
        plt.xlabel("Kondisi Item")
        plt.ylabel("Jumlah Item")
        date_recap = datetime.datetime.today().strftime('%Y-%m-%d')
        plt.title("Rekap per tanggal {}".format(date_recap))
        file_name = "product state {}.png".format(date_recap)
        plt.savefig(file_name)
        return file_name
