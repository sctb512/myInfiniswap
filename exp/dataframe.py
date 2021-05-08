import pandas as pd
import numpy as np
import sys

max = sys.maxsize
min = max*(-1)
n = 1024*1024*int(sys.argv[1])

df1 = pd.DataFrame(np.random.randint(min, max, [n,2]), columns=['key','A'])
df2 = pd.DataFrame(np.random.randint(min, max, [n,2]), columns=['key','B'])
df3 = pd.merge(df1, df2, on='key', how='outer').sort_values(by = 'key')