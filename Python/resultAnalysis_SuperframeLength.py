# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt

t_tilde = []
t_tilde_singleHop = []
t_tilde_fixedRelayLocation = []

# data rate is 150kbps
t = [200, 400, 600, 800, 1000]
# 200ms
t_tilde.append(12.779027495353107)
t_tilde_singleHop.append(8.83955)
t_tilde_fixedRelayLocation.append(10.412)

# 400ms
t_tilde.append(12.778728409195276)
t_tilde_singleHop.append(8.83952)
t_tilde_fixedRelayLocation.append(10.4084)


# 600ms
t_tilde.append(12.779109681559007)
t_tilde_singleHop.append(8.8436)
t_tilde_fixedRelayLocation.append(10.4071)

# 800ms
t_tilde.append(12.779133112243587)
t_tilde_singleHop.append(8.8344)
t_tilde_fixedRelayLocation.append(10.4078)

# 1000ms
t_tilde.append(12.779052854197754)
t_tilde_singleHop.append(8.83397)
t_tilde_fixedRelayLocation.append(10.4124)

# Figure plot
plt.figure()
# plt.figure(figsize=(8,4))
# plt.semilogy(f, np.exp(t_tilde), label="The proposed network", color="red", linewidth=2)
plt.semilogy(t, np.exp(t_tilde), label="The proposed network",color="red", linewidth=2)
# plt.semilogy(f, np.exp(t_tilde_singleHop), label="The single-hop network",marker='d',color="black", linewidth=2,ls="-")

plt.semilogy(t, np.exp(t_tilde_singleHop), label="The single-hop network",color="green", linewidth=2)
plt.semilogy(t, np.exp(t_tilde_fixedRelayLocation), label="The multi-hop network with \nfixed relay location",color="blue", linewidth=2)

plt.grid(True)
# plt.plot(x, z, "b--", label="$cos(x^2)$")
plt.xlabel("Superframe length/ms")
plt.ylabel("Network lifetime/s")
# plt.title("The influence of data rate")
# plt.ylim(-1.2, 1.2)
plt.legend(loc='upper center', bbox_to_anchor=(0.65,0.83),ncol=1,fancybox=True,shadow=True)
# plt.legend()
plt.show()