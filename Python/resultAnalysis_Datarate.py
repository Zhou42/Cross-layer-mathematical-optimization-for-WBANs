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


plt.figure()
# plt.figure(figsize=(8,4))
# plt.semilogy(f, np.exp(t_tilde), label="The proposed network", color="red", linewidth=2)
plt.semilogy(f, np.exp(t_tilde), label="The proposed network",color="red", linewidth=2)
# plt.semilogy(f, np.exp(t_tilde_singleHop), label="The single-hop network",marker='d',color="black", linewidth=2,ls="-")
plt.semilogy(f, np.exp(t_tilde_singleHop), label="The single-hop network",color="green", linewidth=2)
plt.semilogy(f, np.exp(t_tilde_fixedRelayLocation), label="The multi-hop network with \nfixed relay location",color="blue", linewidth=2)

plt.grid(True)
# plt.plot(x, z, "b--", label="$cos(x^2)$")
plt.xlabel("Data rate/Kbps")
plt.ylabel("Network lifetime/s")
# plt.title("The influence of data rate")
# plt.ylim(-1.2, 1.2)
plt.legend(loc='upper center', bbox_to_anchor=(0.65,0.78),ncol=1,fancybox=True,shadow=True)
# plt.legend()
plt.show()