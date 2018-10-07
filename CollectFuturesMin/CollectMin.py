from WindPy import *
import numpy as np
import pandas as pd
from pandas import DataFrame

w.start()

re = w.wsi("RB1901.SHF", "open,high,low,close,volume", "2018-01-16 09:00:00", "2018-10-03 13:01:02", "")

print(re.Fields)
print(re.Times[:3])
re_data = np.array(re.Data)
re_df = DataFrame(re_data.transpose(), columns=["Open", "High", "Low", "Close", "TotalVolume"])
re_df["record_time"] = np.array(re.Times)
re_df["Date"] = pd.to_datetime(re_df["record_time"]).apply(lambda x: x.date())
re_df["Time"] = pd.to_datetime(re_df["record_time"]).apply(lambda x: x.time())
newdf = re_df[["Date", "Time", "Open", "High", "Low", "Close", "TotalVolume"]]
newdf = newdf.dropna()
print(newdf[:3])
print(newdf.dtypes)
newdf.to_csv("rb1901.csv", index=False)

