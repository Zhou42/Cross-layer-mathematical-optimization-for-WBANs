import numpy as np
import matplotlib.pyplot as plt
import scipy.io as scio
# load data files
data_BinarySearch_8sensors = scio.loadmat('./BinarySearch/BinarySearch_Results_40kbps_400ms_8sensors.mat')
data_BinarySearch_9sensors = scio.loadmat('./BinarySearch/BinarySearch_Results_40kbps_400ms_9sensors.mat')
data_BinarySearch_10sensors = scio.loadmat('./BinarySearch/BinarySearch_Results_40kbps_400ms_10sensors.mat')
data_BinarySearch_11sensors = scio.loadmat('./BinarySearch/BinarySearch_Results_40kbps_400ms_11sensors.mat')
data_BinarySearch_12sensors = scio.loadmat('./BinarySearch/BinarySearch_Results_40kbps_400ms_12sensors.mat')
data_BinarySearch_13sensors = scio.loadmat('./BinarySearch/BinarySearch_Results_40kbps_400ms_13sensors.mat')
data_BinarySearch_14sensors = scio.loadmat('./BinarySearch/BinarySearch_Results_40kbps_400ms_14sensors.mat')
data_BinarySearch_15sensors = scio.loadmat('./BinarySearch/BinarySearch_Results_40kbps_400ms_15sensors.mat')
data_BinarySearch_16sensors = scio.loadmat('./BinarySearch/BinarySearch_Results_40kbps_400ms_16sensors.mat')

data_Centralized_8sensors = scio.loadmat('./Centralized/Primal_Results_40kbps_400ms_8sensors.mat')
data_Centralized_9sensors = scio.loadmat('./Centralized/Primal_Results_40kbps_400ms_9sensors.mat')
data_Centralized_10sensors = scio.loadmat('./Centralized/Primal_Results_40kbps_400ms_10sensors.mat')
data_Centralized_11sensors = scio.loadmat('./Centralized/Primal_Results_40kbps_400ms_11sensors.mat')
data_Centralized_12sensors = scio.loadmat('./Centralized/Primal_Results_40kbps_400ms_12sensors.mat')
data_Centralized_13sensors = scio.loadmat('./Centralized/Primal_Results_40kbps_400ms_13sensors.mat')
data_Centralized_14sensors = scio.loadmat('./Centralized/Primal_Results_40kbps_400ms_14sensors.mat')
data_Centralized_15sensors = scio.loadmat('./Centralized/Primal_Results_40kbps_400ms_15sensors.mat')
data_Centralized_16sensors = scio.loadmat('./Centralized/Primal_Results_40kbps_400ms_16sensors.mat')

data_FixedPower_8sensors = scio.loadmat('./FixedPower/relayLocationControlAndFixedPower_Results_40kbps_400ms_8sensors.mat')
data_FixedPower_9sensors = scio.loadmat('./FixedPower/relayLocationControlAndFixedPower_Results_40kbps_400ms_9sensors.mat')
data_FixedPower_10sensors = scio.loadmat('./FixedPower/relayLocationControlAndFixedPower_Results_40kbps_400ms_10sensors.mat')
data_FixedPower_11sensors = scio.loadmat('./FixedPower/relayLocationControlAndFixedPower_Results_40kbps_400ms_11sensors.mat')
data_FixedPower_12sensors = scio.loadmat('./FixedPower/relayLocationControlAndFixedPower_Results_40kbps_400ms_12sensors.mat')
data_FixedPower_13sensors = scio.loadmat('./FixedPower/relayLocationControlAndFixedPower_Results_40kbps_400ms_13sensors.mat')
data_FixedPower_14sensors = scio.loadmat('./FixedPower/relayLocationControlAndFixedPower_Results_40kbps_400ms_14sensors.mat')
data_FixedPower_15sensors = scio.loadmat('./FixedPower/relayLocationControlAndFixedPower_Results_40kbps_400ms_15sensors.mat')
data_FixedPower_16sensors = scio.loadmat('./FixedPower/relayLocationControlAndFixedPower_Results_40kbps_400ms_16sensors.mat')


data_FixedRelayLocation_3sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_3sensors.mat')
data_FixedRelayLocation_4sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_4sensors.mat')
data_FixedRelayLocation_5sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_5sensors.mat')
data_FixedRelayLocation_6sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_6sensors.mat')
data_FixedRelayLocation_7sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_7sensors.mat')
data_FixedRelayLocation_8sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_8sensors.mat')
data_FixedRelayLocation_9sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_9sensors.mat')
data_FixedRelayLocation_10sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_10sensors.mat')
data_FixedRelayLocation_11sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_11sensors.mat')
data_FixedRelayLocation_12sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_12sensors.mat')
data_FixedRelayLocation_13sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_13sensors.mat')
data_FixedRelayLocation_14sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_14sensors.mat')
data_FixedRelayLocation_15sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_15sensors.mat')
data_FixedRelayLocation_16sensors = scio.loadmat('./FixedRelayLocation/FixedRelayLocation_Results_40kbps_400ms_16sensors.mat')

# Plot the lifetime against the number of sensors
numOfSensors = range(3, 18, 1)
lifetime_BinarySearch = [
        data_BinarySearch_8sensors['t_tilde'][0][0],
        data_BinarySearch_9sensors['t_tilde'][0][0],
        data_BinarySearch_10sensors['t_tilde'][0][0],
        data_BinarySearch_11sensors['t_tilde'][0][0],
        data_BinarySearch_12sensors['t_tilde'][0][0],
        data_BinarySearch_13sensors['t_tilde'][0][0],
        data_BinarySearch_14sensors['t_tilde'][0][0],
        data_BinarySearch_15sensors['t_tilde'][0][0],
        data_BinarySearch_16sensors['t_tilde'][0][0],
		13.371856689453125
        ]

lifetime_Centralized = [
        data_Centralized_8sensors['t_tilde_opt'][0][0],
        data_Centralized_9sensors['t_tilde_opt'][0][0],
        data_Centralized_10sensors['t_tilde_opt'][0][0],
        data_Centralized_11sensors['t_tilde_opt'][0][0],
        data_Centralized_12sensors['t_tilde_opt'][0][0],
        data_Centralized_13sensors['t_tilde_opt'][0][0],
        data_Centralized_14sensors['t_tilde_opt'][0][0],
        data_Centralized_15sensors['t_tilde_opt'][0][0],
        data_Centralized_16sensors['t_tilde_opt'][0][0],
		13.375864544969547
        ]

lifetime_FixedPower = [
        data_FixedPower_8sensors['t_tilde_opt'][0][0],
        data_FixedPower_9sensors['t_tilde_opt'][0][0],
        data_FixedPower_10sensors['t_tilde_opt'][0][0],
        data_FixedPower_11sensors['t_tilde_opt'][0][0],
        data_FixedPower_12sensors['t_tilde_opt'][0][0],
        data_FixedPower_13sensors['t_tilde_opt'][0][0],
        data_FixedPower_14sensors['t_tilde_opt'][0][0],
        data_FixedPower_15sensors['t_tilde_opt'][0][0],
        data_FixedPower_16sensors['t_tilde_opt'][0][0],
		12.390648969370655
        ]

lifetime_FixedRelayLocation = [
        data_FixedRelayLocation_3sensors['t_tilde'][0][0],
        data_FixedRelayLocation_4sensors['t_tilde'][0][0],
        data_FixedRelayLocation_5sensors['t_tilde'][0][0],
        data_FixedRelayLocation_6sensors['t_tilde'][0][0],
        data_FixedRelayLocation_7sensors['t_tilde'][0][0],

        data_FixedRelayLocation_8sensors['t_tilde'][0][0],
        data_FixedRelayLocation_9sensors['t_tilde'][0][0],
        data_FixedRelayLocation_10sensors['t_tilde'][0][0],
        data_FixedRelayLocation_11sensors['t_tilde'][0][0],
        data_FixedRelayLocation_12sensors['t_tilde'][0][0],
        data_FixedRelayLocation_13sensors['t_tilde'][0][0],
        data_FixedRelayLocation_14sensors['t_tilde'][0][0],
        data_FixedRelayLocation_15sensors['t_tilde'][0][0],
        data_FixedRelayLocation_16sensors['t_tilde'][0][0],
		11.748908590884060
        ]

# plot the graph
plt.figure()
# plt.semilogy(numOfSensors, np.exp(lifetime_BinarySearch), label="Proposed network with decomposition solution",color="black", marker='+', linestyle="--", fillstyle='none')
# plt.semilogy(numOfSensors, np.exp(lifetime_Centralized), label="Proposed network with centralized solution",color="black", marker='s', linestyle=":", fillstyle='none')

# plt.semilogy(numOfSensors, np.exp(lifetime_FixedPower), label="Multi-hop with fixed transmission power",color="black", marker='o', linestyle="-", fillstyle='none')
plt.semilogy(numOfSensors, np.exp(lifetime_FixedRelayLocation), label="Multi-hop with fixed relay location",color="black", marker='d', linestyle="-", fillstyle='none')

plt.xlabel("Number of sensor nodes")
plt.ylabel("Network lifetime/s")
plt.legend(loc='upper center', bbox_to_anchor=(0.72,0.999), fancybox=True,shadow=True, prop={'size':9})
plt.show()