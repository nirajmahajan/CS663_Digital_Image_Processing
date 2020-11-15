import numpy as np
import matplotlib.pyplot as plt

from getTranslation import getTranslation

I = np.zeros((300,300))
I[50:120,50:100] = 255
translated = np.zeros((300,300))
translated[120:190,20:70] = 255
x,y = getTranslation(I.astype(np.uint8), translated.astype(np.uint8))
