import numpy as np
import matplotlib.pyplot as plt

n_groups = 3

means = [1923.146677, 3423.23489, 43293.34234]
std = [968.345, 352.234, 20399.234]
index = np.arange(n_groups)
error_config = {'ecolor': '0.3'}
opacity = 0.4
bar_width = 0.35
rects1 = plt.bar(index + 0.5 * bar_width, means, bar_width, fill=False, yerr=std, error_kw=error_config)
plt.xticks(index + bar_width, ('Decomposition\nBinary Search', 'Centralized', 'Decomposition\nSubgradient'))
plt.ticklabel_format(style='sci', axis='y', scilimits=(0,0))
plt.ylabel('Running time/s')
plt.show()
