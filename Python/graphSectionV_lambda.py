import numpy as np
import matplotlib.pyplot as plt
import scipy.io as scio

x = np.linspace(0, 6.5, 100)
# y = - 0.75 * (x - 3)**2 + 8
# y = 0.75 * (x - 3)**2 -2
def f(x):
    return 0.35 * (x - 3)**2 + 2.5


fig = plt.figure()
plt.plot(x, f(x), color='black')

plt.tick_params(
    axis='x',          # changes apply to the x-axis
    which='both',      # both major and minor ticks are affected
    labelbottom='off')
plt.tick_params(
    axis='y',          # changes apply to the x-axis
    top='off',         # ticks along the top edge are off
    labelleft='off')

plt.axis([-1.5, 7.5, -2.5, 8.5])

# text 
lower = 1.5
upper = 4
mid = (lower + upper)/2

plt.text(lower, -0.8, '$\lambda_{Lower}$')
plt.text(upper, -0.8, '$\lambda_{Upper}$')
plt.text(mid, -0.8, '$\lambda_{Mid}$')

plt.text(6.5, -0.8, '$\lambda$')
plt.text(-0.8, 8, '$g(\lambda)$')

plt.annotate('Min', xy=(3.1, f(3)+0.1), xytext=(3.5, f(3)+1.5),
            arrowprops=dict(facecolor='red', shrink=0.05),
            )
# plt.text(3, 8.8, 'Optimal')
# dots
value_lower = f(lower)
value_upper = f(upper)

value_mid = f(mid) 


plt.scatter([lower, upper, lower, upper, mid, mid], [0, 0, value_lower, value_upper, 0, value_mid], color='black', linewidth=2)
plt.scatter(3, f(3), color='red', linewidth=2)

plt.plot([lower, lower], [0, value_lower], color='black', linestyle='--')
plt.plot([upper, upper], [0, value_upper], color='black', linestyle='--')
plt.plot([mid, mid], [0, value_mid], color='black', linestyle='--')

plt.box(on=None)
plt.gca().axes.get_xaxis().set_visible(False)
plt.gca().axes.get_yaxis().set_visible(False)

plt.axhline(0, color='black')
plt.axvline(0, color='black')
plt.show()
