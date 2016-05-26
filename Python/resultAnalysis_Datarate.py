# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt

t_tilde = []
t_tilde_singleHop = []
t_tilde_fixedRelayLocation = []

f = [100, 125, 150, 175, 200, 250, 300]
# 100 Kbps
t_tilde.append(13.186737117100977)
t_tilde_singleHop.append(9.24856)
t_tilde_fixedRelayLocation.append(10.8154)

# 125 Kbps
t_tilde.append(12.962013170151346)
t_tilde_singleHop.append(9.02109)
t_tilde_fixedRelayLocation.append(10.5899)


# 150 Kbps
t_tilde.append(12.778728409195276)
t_tilde_singleHop.append(8.83394)
t_tilde_fixedRelayLocation.append(10.4084)

# 175 kbps
t_tilde.append(12.628512698106517)
t_tilde_singleHop.append(8.68945)
t_tilde_fixedRelayLocation.append(10.2573)

# 200 kbps
t_tilde.append(12.494405178542138)
t_tilde_singleHop.append(np.NaN)
t_tilde_fixedRelayLocation.append(10.1188)

# 250 kbps
t_tilde.append(12.247213365266145)
t_tilde_singleHop.append(np.NaN)
t_tilde_fixedRelayLocation.append(9.9007)

# 300 kbps
t_tilde.append(11.778000000000000)
t_tilde_singleHop.append(np.NaN)
t_tilde_fixedRelayLocation.append(9.71687)

# t_tilde_primal_proposed
t_tilde_primal_proposed = [13.230205953857350, 12.998422876820328, 12.848306893117577, 12.629063330593327, 12.499509846240947, 12.220629017778430, 11.780769551609602]




plt.figure()
# plt.figure(figsize=(12,9))
# plt.semilogy(f, np.exp(t_tilde), label="The proposed network", color="red", linewidth=2)
plt.semilogy(f, np.exp(t_tilde), label="Proposed network with decomposition method",color="black", marker='+', linestyle="--", fillstyle='none')
# plt.semilogy(f, np.exp(t_tilde_singleHop), label="The single-hop network",marker='d',color="black", linewidth=2,ls="-")
plt.semilogy(f, np.exp(t_tilde_primal_proposed), label="Proposed network with centralized method",color="black", marker='s', linestyle=":", fillstyle='none')

plt.semilogy(f, np.exp(t_tilde_singleHop), label="Single-hop network",color="black", marker='x', linestyle="-.", fillstyle='none')
plt.semilogy(f, np.exp(t_tilde_fixedRelayLocation), label="Multi-hop network with fixed relay location",color="black", marker='o', linestyle="-", fillstyle='none')



# plt.grid(True)
# plt.plot(x, z, "b--", label="$cos(x^2)$")
plt.xlabel("Data rate/Kbps")
plt.ylabel("Network lifetime/s")
# plt.title("The influence of data rate")
# plt.ylim(-1.2, 1.2)
# plt.legend(loc='upper center', bbox_to_anchor=(0.65,0.78),ncol=1,fancybox=True,shadow=True)
plt.legend(fancybox=True,shadow=True, prop={'size':10})
plt.show()