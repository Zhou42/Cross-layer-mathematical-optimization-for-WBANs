import numpy as np
import matplotlib.pyplot as plt
import scipy.io as scio
# load data files
data_Centralized_7relays = scio.loadmat('./Centralized/7PotentialRelays_Primal_Results_40kbps_400ms_6Relays.mat')
data_Centralized_8relays = scio.loadmat('./Centralized/8PotentialRelays_Primal_Results_40kbps_400ms_6Relays.mat')
data_Centralized_9relays = scio.loadmat('./Centralized/9PotentialRelays_Primal_Results_40kbps_400ms_9Relays.mat')
data_Centralized_10relays = scio.loadmat('./Centralized/10PotentialRelays_Primal_Results_40kbps_400ms_10Relays.mat')
data_Centralized_11relaysA = scio.loadmat('./Centralized/Primal_Results_40kbps_400ms_8Relays_torso_1_38to40.mat')
data_Centralized_11relaysB = scio.loadmat('./Centralized/11PotentialRelays_Primal_Results_40kbps_400ms_7Relays_torso_1_54to56.mat')
data_Centralized_11relaysC = scio.loadmat('./Centralized/11PotentialRelays_Primal_Results_40kbps_400ms_8Relays_torso_1_41to44.mat')
data_Centralized_11relaysD = scio.loadmat('./Centralized/11PotentialRelays_Primal_Results_40kbps_400ms_8Relays_torso_1_45to49.mat')
data_Centralized_11relaysE = scio.loadmat('./Centralized/11PotentialRelays_Primal_Results_40kbps_400ms_8Relays_torso_1_50to53.mat')

# Plot the lifetime against the number of sensors
numOfRelays = range(6, 12, 1)

lifetime_Centralized = [
        13.3719,
        data_Centralized_7relays['t_tilde_opt'][0][0],
        data_Centralized_8relays['t_tilde_opt'][0][0],
        data_Centralized_9relays['t_tilde_opt'][0][0],
        data_Centralized_10relays['t_tilde_opt'][0][0],
        max([data_Centralized_11relaysA['t_tilde_opt'][0][0],
        data_Centralized_11relaysB['t_tilde_opt'][0][0],
        data_Centralized_11relaysC['t_tilde_opt'][0][0],
        data_Centralized_11relaysD['t_tilde_opt'][0][0],
        data_Centralized_11relaysE['t_tilde_opt'][0][0]])
        ]

# plot the graph
plt.figure()
plt.semilogy(numOfRelays, np.exp(lifetime_Centralized),label="Proposed network with decomposition solution", color="black", linestyle="-", fillstyle='none')

plt.xlabel("Number of relay nodes")
plt.ylabel("Network lifetime/s")
plt.legend(loc='upper center', bbox_to_anchor=(0.48,0.96), fancybox=True,shadow=True, prop={'size':12})
plt.show()