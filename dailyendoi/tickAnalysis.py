import json
from pymongo import MongoClient
from datetime import datetime, date, time, timedelta
import pandas as pd
from pandas import DataFrame, Series
config = open('config.json')
setting = json.load(config)

MONGO_HOST = setting['MONGO_HOST']
MONGO_PORT = setting['MONGO_PORT']
TickDb     = setting['tick_db']
symbol     = setting['symbol']
client = MongoClient(MONGO_HOST, MONGO_PORT)
tick_db = client[TickDb]
tick_collection = tick_db[symbol]
print(tick_collection.find({}).count())

#time section
tradingyear = setting['tradingyear']
tradingmonth = setting['tradingmonth']
tradingday = setting['tradingday']
backtest_days = setting['backtest_days']
trading_date = date(tradingyear, tradingmonth, tradingday)
start_time = time(21, 0)
endtime_time = time(15,0)
tstart = datetime.combine(trading_date, start_time)
tend   = datetime.combine(trading_date + timedelta(days = backtest_days), endtime_time)
query_condition = {'datetime': {'$gte': tstart, '$lte': tend}}
print(query_condition)
cursor = tick_collection.find(query_condition)
df = DataFrame(list(cursor))
df.to_csv('daystick.csv')
print(df['lastPrice'][ :5])
# print(df)
