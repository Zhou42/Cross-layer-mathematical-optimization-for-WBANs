# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
import scipy.io as scio  
# 载入mat文件
data_10kbps_400ms_binarysearch = scio.loadmat('../Results_10kbps_400ms_binarysearch_decomposition.mat')
data_20kbps_400ms_binarysearch = scio.loadmat('../Results_20kbps_400ms_binarysearch_decomposition.mat')
data_30kbps_400ms_binarysearch = scio.loadmat('../Results_30kbps_400ms_binarysearch_decomposition.mat')
data_40kbps_400ms_binarysearch = scio.loadmat('../Results_40kbps_400ms_binarysearch_decomposition.mat')
data_45kbps_400ms_binarysearch = scio.loadmat('../Results_45kbps_400ms_binarysearch_decomposition.mat')
data_50kbps_400ms_binarysearch = scio.loadmat('../Results_50kbps_400ms_binarysearch_decomposition.mat')
data_FixedRelayLocation_10kbps_400ms = scio.loadmat('../Multihop_FixedRelayLocation_Results_10kbps_400ms.mat')
data_FixedRelayLocation_20kbps_400ms = scio.loadmat('../Multihop_FixedRelayLocation_Results_20kbps_400ms.mat')
data_FixedRelayLocation_30kbps_400ms = scio.loadmat('../Multihop_FixedRelayLocation_Results_30kbps_400ms.mat')
data_FixedRelayLocation_40kbps_400ms = scio.loadmat('../Multihop_FixedRelayLocation_Results_40kbps_400ms.mat')
data_FixedRelayLocation_45kbps_400ms = scio.loadmat('../Multihop_FixedRelayLocation_Results_45kbps_400ms.mat')
data_FixedRelayLocation_50kbps_400ms = scio.loadmat('../Multihop_FixedRelayLocation_Results_50kbps_400ms.mat')
data_relayLocationControlAndFixedPower_10kbps_400ms = scio.loadmat('../relayLocationControlAndFixedPower_Results_10kbps_400ms.mat')
data_relayLocationControlAndFixedPower_20kbps_400ms = scio.loadmat('../relayLocationControlAndFixedPower_Results_20kbps_400ms.mat')
data_relayLocationControlAndFixedPower_30kbps_400ms = scio.loadmat('../relayLocationControlAndFixedPower_Results_30kbps_400ms.mat')
data_relayLocationControlAndFixedPower_40kbps_400ms = scio.loadmat('../relayLocationControlAndFixedPower_Results_40kbps_400ms.mat')
data_relayLocationControlAndFixedPower_45kbps_400ms = scio.loadmat('../relayLocationControlAndFixedPower_Results_45kbps_400ms.mat')
data_relayLocationControlAndFixedPower_50kbps_400ms = scio.loadmat('../relayLocationControlAndFixedPower_Results_50kbps_400ms.mat')
Primal_10kbps_400ms = scio.loadmat('../DualityGap/Primal_Results_10kbps_400ms.mat')
Primal_20kbps_400ms = scio.loadmat('../DualityGap/Primal_Results_20kbps_400ms.mat')
Primal_30kbps_400ms = scio.loadmat('../DualityGap/Primal_Results_30kbps_400ms.mat')
Primal_40kbps_400ms = scio.loadmat('../DualityGap/Primal_Results_40kbps_400ms.mat')
Primal_45kbps_400ms = scio.loadmat('../DualityGap/Primal_Results_45kbps_400ms.mat')
Primal_50kbps_400ms = scio.loadmat('../DualityGap/Primal_Results_50kbps_400ms.mat')


#
t_tilde = []
t_tilde_singleHop = []
t_tilde_fixedRelayLocation = []
t_tilde_fixedPower = []

f = [10, 20, 30, 40, 45, 50]
# 10 Kbps
t_tilde.append(data_10kbps_400ms_binarysearch['t_tilde'][0][0])
# t_tilde_singleHop.append(9.24856)
t_tilde_fixedRelayLocation.append(data_FixedRelayLocation_10kbps_400ms['t_tilde'][0][0])
t_tilde_fixedPower.append(data_relayLocationControlAndFixedPower_10kbps_400ms['t_tilde_opt'][0][0])

# 20 Kbps
t_tilde.append(data_20kbps_400ms_binarysearch['t_tilde'][0][0])
# t_tilde_singleHop.append(9.02109)
t_tilde_fixedRelayLocation.append(data_FixedRelayLocation_20kbps_400ms['t_tilde'][0][0])
t_tilde_fixedPower.append(data_relayLocationControlAndFixedPower_20kbps_400ms['t_tilde_opt'][0][0])

# 30 Kbps
t_tilde.append(data_30kbps_400ms_binarysearch['t_tilde'][0][0])
# t_tilde_singleHop.append(8.83394)
t_tilde_fixedRelayLocation.append(data_FixedRelayLocation_30kbps_400ms['t_tilde'][0][0])
t_tilde_fixedPower.append(data_relayLocationControlAndFixedPower_30kbps_400ms['t_tilde_opt'][0][0])

# 40 kbps
t_tilde.append(data_40kbps_400ms_binarysearch['t_tilde'][0][0])
# t_tilde_singleHop.append(8.68945)
t_tilde_fixedRelayLocation.append(data_FixedRelayLocation_40kbps_400ms['t_tilde'][0][0])
t_tilde_fixedPower.append(data_relayLocationControlAndFixedPower_40kbps_400ms['t_tilde_opt'][0][0])

# 45 kbps
t_tilde.append(data_45kbps_400ms_binarysearch['t_tilde'][0][0])
# t_tilde_singleHop.append(np.NaN)
t_tilde_fixedRelayLocation.append(data_FixedRelayLocation_45kbps_400ms['t_tilde'][0][0])
t_tilde_fixedPower.append(data_relayLocationControlAndFixedPower_45kbps_400ms['t_tilde_opt'][0][0])

# 50 kbps
t_tilde.append(data_50kbps_400ms_binarysearch['t_tilde'][0][0])
# t_tilde_singleHop.append(np.NaN)
t_tilde_fixedRelayLocation.append(data_FixedRelayLocation_50kbps_400ms['t_tilde'][0][0])
t_tilde_fixedPower.append(data_relayLocationControlAndFixedPower_50kbps_400ms['t_tilde_opt'][0][0])
# t_tilde_primal_proposed
t_tilde_primal_proposed = [Primal_10kbps_400ms['t_tilde_opt'][0][0], Primal_20kbps_400ms['t_tilde_opt'][0][0], Primal_30kbps_400ms['t_tilde_opt'][0][0], Primal_40kbps_400ms['t_tilde_opt'][0][0], Primal_45kbps_400ms['t_tilde_opt'][0][0], Primal_50kbps_400ms['t_tilde_opt'][0][0]]




plt.figure()
# plt.figure(figsize=(12,9))
# plt.semilogy(f, np.exp(t_tilde), label="The proposed network", color="red", linewidth=2)
plt.semilogy(f, np.exp(t_tilde), label="Proposed network with decomposition solution",color="black", marker='+', linestyle="--", fillstyle='none')
# plt.semilogy(f, np.exp(t_tilde_singleHop), label="The single-hop network",marker='d',color="black", linewidth=2,ls="-")
plt.semilogy(f, np.exp(t_tilde_primal_proposed), label="Proposed network with centralized solution",color="black", marker='s', linestyle=":", fillstyle='none')
# plt.semilogy(f, np.exp(t_tilde_singleHop), label="Single-hop network",color="black", marker='x', linestyle="-.", fillstyle='none')
plt.semilogy(f, np.exp(t_tilde_fixedRelayLocation), label="Multi-hop with fixed relay location",color="black", marker='o', linestyle="-", fillstyle='none')
plt.semilogy(f, np.exp(t_tilde_fixedPower), label="Multi-hop with fixed transmission power",color="black", marker='d', linestyle="-", fillstyle='none')



# plt.grid(True)
# plt.plot(x, z, "b--", label="$cos(x^2)$")
plt.xlabel("Data rate/Kbps")
plt.ylabel("Network lifetime/s")
# plt.title("The influence of data rate")
# plt.ylim(-1.2, 1.2)
# plt.legend(loc='upper center', bbox_to_anchor=(0.65,0.78),ncol=1,fancybox=True,shadow=True)
# plt.legend(loc='upper center', bbox_to_anchor=(0.66,0.685), fancybox=True,shadow=True, prop={'size':10})
plt.legend(loc='upper center', bbox_to_anchor=(0.63,0.935), fancybox=True,shadow=True, prop={'size':10})
plt.show()
