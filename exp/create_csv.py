import pandas as pd
import numpy as np
import sys

max = sys.maxsize
min = max*(-1)
n = 1024*1024*int(sys.argv[1])

d1 = pd.DataFrame(np.random.randint(min, max, [n,2]), columns=['key','A'])
d2 = pd.DataFrame(np.random.randint(min, max, [n,2]), columns=['key','B'])

d1.to_csv('test_'+sys.argv[1]+'_1.csv', index=False)
d2.to_csv('test_'+sys.argv[1]+'_2.csv', index=False)