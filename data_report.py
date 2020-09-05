import seaborn as sns
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
