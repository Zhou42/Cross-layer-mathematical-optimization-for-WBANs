import numpy as np
import matplotlib.pyplot as plt
import scipy.io as scio

dataFile = '../Results_40kbps_400ms_binarysearch_decomposition.mat'
data = scio.loadmat(dataFile)
S_num = 17

B = data['B']
T = np.exp(data['T_tilde'])
P = np.exp(data['P_tilde'])
T_frame = data['T_frame']
lifetime_vector = []

lifetime = (B[:S_num] * T_frame)/(T[:S_num] * P[:S_num])
for i in range(len(lifetime)):
	lifetime_vector.append(lifetime[i][0])

# plots
plt.figure()
plt.ticklabel_format(style='sci', axis='y', scilimits=(0, 0))
plt.bar(range(1, S_num + 1), lifetime_vector, fill=False)
plt.xlabel("Sensor index")
plt.ylabel("Lifetime/s")
plt.show()