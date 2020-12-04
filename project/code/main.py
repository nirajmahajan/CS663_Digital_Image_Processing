import numpy as np
import scipy
import sklearn
from sklearn.decomposition import PCA as PP
import matplotlib.pyplot as plt
import os
import argparse
import sys
import time
import random

from classes import PCA, FLD
from utils import *

seed = 1
random.seed(seed)
os.environ['PYTHONHASHSEED'] = str(seed)
np.random.seed(seed)


a = FLD(4)
data = np.random.randn(500,4)
a.fit(data, np.arange(500)//50)