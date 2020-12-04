import numpy as np
import scipy
import matplotlib.pyplot as plt
import os

class PCA(object):
	"""takes a nxd input matrix X and stores a PCA model to transform to a k dimensional space"""
	def __init__(self, n_components = 1):
		super(PCA, self).__init__()
		self.n_components = n_components

	def fit(self, X):
		self.mean = X.mean(0)
		self.insize = X.shape[1]
		n_data = X.shape[0]
		assert(self.n_components <= n_data)
		X_norm = X - self.mean.reshape(1,-1)
		mat = (X_norm@X_norm.T)/(n_data - 1)
		[eigvals, eigvecs] = np.linalg.eigh(mat)
		indices = np.argsort(eigvals)[::-1]
		self.eigvals_all = eigvals[indices]
		indices = indices[:self.n_components]
		eigvals = eigvals[indices]
		eigvecs_big = X.T@eigvecs
		norms = (eigvecs_big**2).sum(0).reshape(1,-1) ** 0.5
		eigvecs_big = eigvecs_big/(norms+1e-8)
		# dxn_components
		self.eigvals_chosen = eigvals
		self.transform_mat = eigvecs_big[:,indices]

	def fit_transform(self, X):
		self.fit(X)
		return self.transform(X)

	def transform(self, X):
		# mxd 
		assert(self.insize == X.shape[1])
		return -(X - self.mean.reshape(1,-1))@self.transform_mat


