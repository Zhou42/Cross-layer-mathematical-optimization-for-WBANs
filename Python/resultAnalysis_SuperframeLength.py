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
# t_tilde_singleHop = []
t_tilde_fixedRelayLocation = []

# data rate is 40kbps
t = [200, 400, 600, 800, 1000]
'''
# 200ms
t_tilde.append(data_40kbps_400ms_binarysearch['t_tilde'][0][0])
# t_tilde_singleHop.append(8.83955)
t_tilde_fixedRelayLocation.append(data_FixedRelayLocation_40kbps_400ms['t_tilde'][0][0])

# 400ms
t_tilde.append(12.778728409195276)
# t_tilde_singleHop.append(8.83952)
t_tilde_fixedRelayLocation.append(10.4084)


# 600ms
t_tilde.append(12.779109681559007)
# t_tilde_singleHop.append(8.8436)
t_tilde_fixedRelayLocation.append(10.4071)

# 800ms
t_tilde.append(12.779133112243587)
# t_tilde_singleHop.append(8.8344)
t_tilde_fixedRelayLocation.append(10.4078)

# 1000ms
t_tilde.append(12.779052854197754)
# t_tilde_singleHop.append(8.83397)
t_tilde_fixedRelayLocation.append(10.4124)
'''

# t_tilde_primal_proposed
t_tilde = data_40kbps_400ms_binarysearch['t_tilde'][0][0] * np.ones(5)
t_tilde_primal_proposed = Primal_40kbps_400ms['t_tilde_opt'][0][0] * np.ones(5)
t_tilde_fixedPower = data_relayLocationControlAndFixedPower_40kbps_400ms['t_tilde_opt'][0][0] * np.ones(5)
t_tilde_fixedRelayLocation = data_FixedRelayLocation_40kbps_400ms['t_tilde'][0][0] * np.ones(5) 

# Figure plot
plt.figure()
# plt.figure(figsize=(12,9))
'''
plt.semilogy(t, np.exp(t_tilde), label="The proposed network",color="red", linewidth=2)
plt.semilogy(t, np.exp(t_tilde_singleHop), label="The single-hop network",color="green", linewidth=2)
plt.semilogy(t, np.exp(t_tilde_fixedRelayLocation), label="The multi-hop network with \nfixed relay location",color="blue", linewidth=2)
'''

plt.semilogy(t, np.exp(t_tilde), label="Proposed network with decomposition method",color="black", marker='+', linestyle="--", fillstyle='none')
# plt.semilogy(f, np.exp(t_tilde_singleHop), label="The single-hop network",marker='d',color="black", linewidth=2,ls="-")
plt.semilogy(t, np.exp(t_tilde_primal_proposed), label="Proposed network with centralized method",color="black", marker='s', linestyle=":", fillstyle='none')

# plt.semilogy(t, np.exp(t_tilde_singleHop), label="Single-hop network",color="black", marker='x', linestyle="-.", fillstyle='none')
plt.semilogy(t, np.exp(t_tilde_fixedRelayLocation), label="Multi-hop with fixed relay location",color="black", marker='o', linestyle="-", fillstyle='none')

plt.semilogy(t, np.exp(t_tilde_fixedPower), label="Multi-hop with fixed transmission power",color="black", marker='d', linestyle="-", fillstyle='none')


# plt.grid(True)
# plt.plot(x, z, "b--", label="$cos(x^2)$")
plt.xlabel("Superframe length/ms")
plt.ylabel("Network lifetime/s")
# plt.title("The influence of data rate")
# plt.ylim(-1.2, 1.2)
plt.legend(loc='upper center', bbox_to_anchor=(0.65,0.77),ncol=1,fancybox=True,shadow=True, prop={'size':10})
# plt.legend()
plt.show()