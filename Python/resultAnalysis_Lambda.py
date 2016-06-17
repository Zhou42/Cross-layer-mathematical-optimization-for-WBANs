import numpy as np
import matplotlib.pyplot as plt
import scipy.io as scio
# Data loading
data_10kbps_400ms_binarysearch = scio.loadmat('../Results_10kbps_400ms_binarysearch_decomposition.mat')
data_20kbps_400ms_binarysearch = scio.loadmat('../Results_20kbps_400ms_binarysearch_decomposition.mat')
data_30kbps_400ms_binarysearch = scio.loadmat('../Results_30kbps_400ms_binarysearch_decomposition.mat')
data_40kbps_400ms_binarysearch = scio.loadmat('../Results_40kbps_400ms_binarysearch_decomposition.mat')
data_45kbps_400ms_binarysearch = scio.loadmat('../Results_45kbps_400ms_binarysearch_decomposition.mat')
data_50kbps_400ms_binarysearch = scio.loadmat('../Results_50kbps_400ms_binarysearch_decomposition.mat')

data_40kbps_200ms_binarysearch = scio.loadmat('../Results_40kbps_200ms_binarysearch_decomposition.mat')
data_40kbps_600ms_binarysearch = scio.loadmat('../Results_40kbps_600ms_binarysearch_decomposition.mat')
data_40kbps_800ms_binarysearch = scio.loadmat('../Results_40kbps_800ms_binarysearch_decomposition.mat')
data_40kbps_1000ms_binarysearch = scio.loadmat('../Results_40kbps_1000ms_binarysearch_decomposition.mat')


# lambda vs data rate
f = [10, 20, 30, 40, 45, 50] 
lambda_datarate = [data_10kbps_400ms_binarysearch['lambda'][0][0], \
					data_20kbps_400ms_binarysearch['lambda'][0][0], \
					data_30kbps_400ms_binarysearch['lambda'][0][0], \
					data_40kbps_400ms_binarysearch['lambda'][0][0], \
					data_45kbps_400ms_binarysearch['lambda'][0][0], \
					data_50kbps_400ms_binarysearch['lambda'][0][0]]

plt.figure()
plt.plot(f, lambda_datarate,label="Lambda",color='black')
plt.legend(loc="upper center", bbox_to_anchor=(0.8,0.95),fancybox=True, shadow=True)
plt.xlabel("Data rate/Kbps")
plt.ylabel("Lambda")
plt.show()

# lambda vs superframe length
t = [200, 400, 600, 800, 1000]
lambda_superframeLength = [data_40kbps_200ms_binarysearch['lambda'][0][0], \
							data_40kbps_400ms_binarysearch['lambda'][0][0], \
							data_40kbps_600ms_binarysearch['lambda'][0][0], \
							data_40kbps_800ms_binarysearch['lambda'][0][0], \
							data_40kbps_1000ms_binarysearch['lambda'][0][0]]

plt.figure()
plt.plot(t, lambda_superframeLength,label="Lambda",color='black')
plt.legend(loc="upper center", bbox_to_anchor=(0.8,0.95),fancybox=True, shadow=True)
plt.xlabel("Superframe length/ms")
plt.ylabel("Lambda")
plt.show()
