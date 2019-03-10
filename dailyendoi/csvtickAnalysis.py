import pandas as pd
from pandas import DataFrame, Series
import json
config = open('config.json')
setting = json.load(config)
df = DataFrame.from_csv('daystick.csv')
# print(df['lastPrice'][:5])
print(df.shape())
