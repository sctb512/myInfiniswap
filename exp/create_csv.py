import pandas as pd
import numpy as np
import sys


max = sys.maxsize
min = max*(-1)
n = 15*1024*1024

d1 = pd.DataFrame(np.random.randint(min, max, [n,2]), columns=['key','A'])
d2 = pd.DataFrame(np.random.randint(min, max, [n,2]), columns=['key','B'])

d1.to_csv('df1.csv', index=False)
d2.to_csv('df2.csv', index=False)