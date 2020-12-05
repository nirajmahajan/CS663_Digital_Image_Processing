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

class YaleDataset(object):
	"""docstring for YaleDataset"""
	def __init__(self, path):
		super(YaleDataset, self).__init__()
		self.path = path
		self.len = 165
		self.Xtrain = np.zeros((105,77760))
		self.Ytrain = np.zeros((105)).astype(np.int32)
		self.Xtest = np.zeros((60,77760))
		self.Ytest = np.zeros((60)).astype(np.int32)
		self.X_glasses = np.zeros((30,77760))
		self.Y_glasses = np.zeros((30)).astype(np.int32)


		glass_counter = 0
		train_counter = 0
		test_counter = 0
		choice_counters = np.zeros(15).astype(np.int32)
		trainchoices = np.zeros((15,11)).astype(np.int32)
		for i in range(15):
			trainchoices[i,np.random.choice(11,7,replace = False)] = 1

		for filename in os.listdir(self.path):
			if filename.endswith(".txt"):
				continue
			fullpath = os.path.join(self.path, filename)
			image = plt.imread(fullpath)
			personid = int(filename[7:9])-1
			if trainchoices[personid, choice_counters[personid]] == 1:
				# train
				self.Xtrain[train_counter,:] = image.reshape(-1)
				self.Ytrain[train_counter] = personid
				train_counter += 1
			else:
				# test
				self.Xtest[test_counter,:] = image.reshape(-1)
				self.Ytest[test_counter] = personid
				test_counter += 1
			
			# increment choice counter
			choice_counters[personid] += 1

			if "noglasses" in filename:
				self.X_glasses[glass_counter,:] = image.reshape(-1)
				self.Y_glasses[glass_counter] = 0
				glass_counter += 1
			elif "glasses" in filename:
				self.X_glasses[glass_counter,:] = image.reshape(-1)
				self.Y_glasses[glass_counter] = 1
				glass_counter += 1
