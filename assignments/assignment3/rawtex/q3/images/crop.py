import matplotlib.pyplot as plt
import numpy as np


bird_name = 'bird_kernel_'
flower_name = 'flower_kernel_'

lst = ['0.20','0.40','0.60','0.80','1.00']

for j in range(2):
	for i in range(5):
		if j == 0:
			name = bird_name + lst[i]
		else:
			name = flower_name + lst[i]
		im = plt.imread(name+'.png')
		if j == 0:
			c = im[15:172,130:302,:]
		else:
			c = im[15:115,130:237,:]
		plt.imshow(c)
		plt.savefig(name + '_cropped.png')