import json
from mongoengine import DecimalField, FloatField, StringField
from mongoengine import connect, Document
config = open('dailyendoi/config.json')
setting = json.load(config)

MONGO_HOST = setting['MONGO_HOST']
MONGO_PORT = setting['MONGO_PORT']
TickDb     = setting['tick_db']
symbol     = setting['symbol']

print(connect(TickDb, host = MONGO_HOST, port = MONGO_PORT))

class Tick(Document):
    vtSymbol = StringField()
    lastPrice = DecimalField()
    bidPrice1 = DecimalField()
    askPrice1 = DecimalField()
    openInterest = DecimalField()
    volume = FloatField()
    bidVolume1 = FloatField()
    askVolume1 = FloatField()


if __name__ == "__main__":
    pass
