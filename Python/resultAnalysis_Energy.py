import numpy as np
import matplotlib.pyplot as plt
import scipy.io as scio

dataFile = '../DualityGap/EnergyResults.mat'
energyDict = scio.loadmat(dataFile)
f = [10, 20, 30, 40, 45, 50]

plt.figure()
plt.ticklabel_format(style='sci', axis='y', scilimits=(0, 0))
plt.plot(f, energyDict['energyConsumption_proposed_decomposition'][0],  label="Proposed network with decomposition solution",color="black", marker='+', linestyle="--", fillstyle='none')
plt.plot(f, energyDict['energyConsumption_centralized'][0], label="Proposed network with centralized solution",color="black", marker='s', linestyle=":", fillstyle='none')
# plt.plot(f, energyDict['energyConsumption_SingleHop'][0], label="Single-hop network",color="black", marker='x', linestyle="-.", fillstyle='none')
plt.plot(f, energyDict['energyConsumption_Multihop_FixedRelayLocation'][0], label="Multi-hop with fixed relay location",color="black", marker='o', linestyle="-", fillstyle='none')
plt.plot(f, energyDict['energyConsumption_Multihop_FixedPower'][0], label="Multi-hop with fixed transmission power",color="black", marker='d', linestyle="-", fillstyle='none')

plt.xlabel("Data rate/Kbps")
plt.ylabel("Energy consumption per superframe/J")
plt.legend(loc='upper center', bbox_to_anchor=(0.43, 0.8), fancybox=True,shadow=True, prop={'size':10})

plt.show()
