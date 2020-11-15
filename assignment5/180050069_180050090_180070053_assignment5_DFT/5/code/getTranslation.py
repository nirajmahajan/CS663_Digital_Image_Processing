import numpy as np

def getTranslation(I1,I2):
    F1 = np.fft.fft2(I1)
    F2 = np.fft.fft2(I2)
    Prod = (F1*np.conj(F2))/abs(F1*F2)
    prod = np.abs(np.fft.ifft2(Prod))
    y = np.argmax(prod.sum(0))
    x = np.argmax(prod.sum(1))
    return x,y