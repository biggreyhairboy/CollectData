import pandas as pd
from pandas import DataFrame, Series
import json
config = open('config.json')
setting = json.load(config)
df = DataFrame.from_csv('daystick.csv')
# print(df['lastPrice'][:5])
# with pd.option_context('display.max_rows', None, 'display.max_columns', None):
    # print(df[:][0:5])


morning_five_min = df['time' < time(9,5,0), 'time' >= time(9,0,0)]
print(morning_five_min[:][0:5])
