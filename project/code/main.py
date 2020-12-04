import numpy as np
import scipy
import matplotlib.pyplot as plt
import os
import argparse
import sys
import time
import random

seed = 1
random.seed(seed)
os.environ['PYTHONHASHSEED'] = str(seed)
np.random.seed(seed)