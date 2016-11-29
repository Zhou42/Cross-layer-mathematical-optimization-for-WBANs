import numpy as np
import matplotlib.pyplot as plt

n_groups = 3

decomposition_binarysearch = [1096.43801474246, 1729.33761384680, 1887.90467178789, 2303.17488903769, 2227.16116236906, 1848.75229361908, 1882.05259765977, 1344.07437235346, 2728.82341619547, 943.732094908232]
centralized = [2775.58287020282,3673.88851580938,3320.27324869771,2945.81905366515,3385.01835574842,3711.34286325101,3701.20530902857,3637.67033529465,3205.24774028669,3290.69071631138]
decompostion_subgradient = [42080.5311346083, 66825.7385729534, 61990.6273482255, 25589.1873786431, 64501.7971615422]

means = [np.mean(decomposition_binarysearch), np.mean(centralized), np.mean(decompostion_subgradient)] # [1923.146677, 3423.23489, 43293.34234]
std = [np.std(decomposition_binarysearch), np.std(centralized), np.std(decompostion_subgradient)] # [968.345, 352.234, 20399.234]
# means = [1923.146677, 3423.23489, 43293.34234]
# std = [968.345, 352.234, 20399.234]
# print means
# print std
index = np.arange(n_groups)
error_config = {'ecolor': '0.3'}
opacity = 0.4
bar_width = 0.35
rects1 = plt.bar(index + 0.5 * bar_width, means, bar_width, fill=False, yerr=std, error_kw=error_config)
plt.xticks(index + bar_width, ('Decomposition\nBinary Search', 'Centralized', 'Decomposition\nSubgradient'))
plt.ticklabel_format(style='sci', axis='y', scilimits=(0,0))
plt.ylabel('Running time/s')
# plt.show()
plt.savefig('runningtime.eps')