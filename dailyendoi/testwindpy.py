import numpy as np
from WindPy import *
import numpy as np
from pandas import DataFrame
import matplotlib as plt
w.start()


# print w.wsd("600000.SH", "high", "2013-05- 09", datetime.today(), "Period=W")
dset = w.wset("futureoir","startdate=2017-07-29;enddate=2017-12-22;varity=RB.SHF;wind_code=RB1805.SHF;order_by=long;ranks=all;field=date,member_name,long_position_increase,short_position,vol,settle")
# print(dset.Data)
ddata = np.array(dset.Data)
df = DataFrame(ddata.transpose(), columns =['date', 'member_name', 'long_position_increase', 'short_position', ' vol', ' settle'])
# print(df)
dfzhongxin = df[df["member_name"] == '上海大陆']
# df.to_csv("increase.csv")
dfzhongxin.to_csv("shanghaidalu.csv")
print(dfzhongxin)



