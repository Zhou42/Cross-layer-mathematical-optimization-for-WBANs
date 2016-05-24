import numpy as np
import matplotlib.pyplot as plt

# lambda vs data rate
f = [100, 125, 150, 175, 200, 250, 300]
lambda_datarate = [7.961339822800525e-04, 0.004973046008221, 0.005722566110646, 0.011568638510470, 0.025157586670611, 2.249832686522610, 6.900033262292621]

plt.figure()
plt.plot(f, lambda_datarate,label="Lambda",linewidth=2)
plt.legend(loc="upper center", bbox_to_anchor=(0.8,0.95),fancybox=True, shadow=True)
plt.xlabel("Data rate/Kbps")
plt.ylabel("Lambda")
plt.show()

# lambda vs superframe length
t = [200, 400, 600, 800, 1000]
lambda_superframeLength = [0.011015306231360, 0.005722566110646, 0.004421849443518, 0.003442564424474, 0.003079937519812]

plt.figure()
plt.plot(t, lambda_superframeLength,label="Lambda",linewidth=2)
plt.legend(loc="upper center", bbox_to_anchor=(0.8,0.95),fancybox=True, shadow=True)
plt.xlabel("Superframe length/ms")
plt.ylabel("Lambda")
plt.show()
