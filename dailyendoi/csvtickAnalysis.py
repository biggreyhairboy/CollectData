import pandas as pd
from pandas import DataFrame, Series
from datetime import datetime, time
import json
config = open('dailyendoi/config.json')
setting = json.load(config)
df = pd.read_csv('dailyendoi/daystick.csv', parse_dates=True)
# print(df['lastPrice'][:5])
# with pd.option_context('display.max_rows', None, 'display.max_columns', None):
    # print(df[:][0:5])
df.dropna()
df['datetime'] = pd.to_datetime(df['datetime'], format='%Y-%m-%d %H:%M:%S.%f')
df['time'] = pd.to_datetime(df['time'], format='%H:%M:%S.%f').dt.time
# morning_five_min = df.loc[(df['time'] < time(9, 0, 5)) & (df['time'] >= time(9, 0, 0)), 'time']
morning_five_min = df[(df['time'] <= time(9, 0, 5)) &
                      (df['time'] >= time(9, 0, 0))]
# print(df['time'] < time(9, 5, 0))
# print(df.dtypes)
# print(morning_five_min)
print(morning_five_min.shape)
