import json
from WindPy import *
import numpy as np
from pandas import DataFrame

w.start()
setting = json.load(open('config.json'))
startdate = setting['startdate']
enddate   = setting['enddate']
variety   = setting['variety']
wind_code = setting['wind_code']

# print w.wsd("600000.SH", "high", "2013-05- 09", datetime.today(), "Period=W")
#  获取原始数据
selectscope = "startdate=" + startdate + ";enddate=" + enddate + ";varity=" + variety + ";wind_code=" + wind_code
selectcondition = selectscope  + ";order_by=long;ranks=all;" \
                                 "field=date,member_name,long_position,short_position,vol,settle"
dset = w.wset("futureoir", selectcondition)
# print(dset.Data)

#  转变为dataframe方便操作，并且转变成需要的格式
ddata = np.array(dset.Data)
df = DataFrame(ddata.transpose(), columns=['date', 'member_name',\
                                            'long_position', 'short_position', 'vol', 'settle'])
stripemtytime = lambda x: x.date()
dateseries = df['date'].apply(stripemtytime)
df['date'] = dateseries
# print(dateseries)
# print(df)
df = df.sort_values(by='date')
# shanghaidalu = df[df["member_name"] == '上海大陆']
acompany = df[df["member_name"] == '永安期货']
# df.to_csv("increase.csv")
acompany.to_csv("yonganqihuo.csv", index=False)
print(acompany)
