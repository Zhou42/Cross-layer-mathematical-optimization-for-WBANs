import numpy as np
import matplotlib.pyplot as plt
import scipy.io as scio

dataFile = '../Results_40kbps_400ms_binarysearch_decomposition.mat'
data_binarysearch = scio.loadmat(dataFile)
S_num = 17

B = data_binarysearch['B']
T = np.exp(data_binarysearch['T_tilde'])
P = np.exp(data_binarysearch['P_tilde'])
T_frame = data_binarysearch['T_frame']
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

# calculate the Jain's fairness
JFairness_binarysearch = sum(lifetime_vector)**2/(len(lifetime_vector) * sum(np.square(lifetime_vector)))


# calculate other methods fairness
data_FixedPower = scio.loadmat('../relayLocationControlAndFixedPower_Results_40kbps_400ms.mat')
B = data_FixedPower['B']
T = np.exp(data_FixedPower['T_tilde_opt'])
P = np.ones((S_num,)) * 0.0001
T_frame = data_FixedPower['T_frame']
lifetime_vector = []

lifetime = (B[:S_num] * T_frame)/(T[:S_num] * P[:S_num])
for i in range(len(lifetime)):
	lifetime_vector.append(lifetime[i][0])

plt.figure()
plt.ticklabel_format(style='sci', axis='y', scilimits=(0, 0))
plt.bar(range(1, S_num + 1), lifetime_vector, fill=False)
plt.xlabel("Sensor index")
plt.ylabel("Lifetime/s")
plt.show()

JFairness_FixedPower = sum(lifetime_vector)**2/(len(lifetime_vector) * sum(np.square(lifetime_vector)))


# calculate other methods fairness
data_FixedLocation = scio.loadmat('../Multihop_FixedRelayLocation_Results_40kbps_400ms.mat')
B = data_FixedLocation['B']
T = np.exp(data_FixedLocation['T_tilde'])
P = np.exp(data_FixedLocation['P_tilde'])
T_frame = data_FixedLocation['T_frame']
lifetime_vector = []

lifetime = (B[:S_num] * T_frame)/(T[:S_num] * P[:S_num])
for i in range(len(lifetime)):
	lifetime_vector.append(lifetime[i][0])

plt.figure()
plt.ticklabel_format(style='sci', axis='y', scilimits=(0, 0))
plt.bar(range(1, S_num + 1), lifetime_vector, fill=False)
plt.xlabel("Sensor index")
plt.ylabel("Lifetime/s")
plt.show()

data_FixedLocation = sum(lifetime_vector)**2/(len(lifetime_vector) * sum(np.square(lifetime_vector)))

print JFairness_binarysearch, JFairness_FixedPower, data_FixedLocation
