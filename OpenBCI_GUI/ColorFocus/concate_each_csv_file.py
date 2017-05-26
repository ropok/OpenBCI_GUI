import pandas as pd
import glob
import numpy as np

file1 = 'Z1_colorFocus.csv'

a = pd.read_csv(file1)
##b = pd.read_csv('Feature_Kelas_2.csv')

##val = pd.concat([a,b],axis=1)
##val = pd.concat([val,c],axis=1)


df = pd.DataFrame(a);
##df.to_csv("Feature_train_uniform_lbp.csv",mode='a')

