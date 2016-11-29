import numpy as np
import matplotlib.pyplot as plt
import scipy.io as scio

def f(x):
    y = - 0.05 * (x - 10)**2 + 9
    return y

x = np.linspace(1, 11, 100)
y = f(x)

fig = plt.figure()
plt.plot(x, y, color='black')

plt.tick_params(
    axis='x',          # changes apply to the x-axis
    which='both',      # both major and minor ticks are affected
    labelbottom='off')
plt.tick_params(
    axis='y',          # changes apply to the x-axis
    top='off',         # ticks along the top edge are off
    labelleft='off')

plt.axis([-2, 17, -2, 11])

# text 
lower = 3
upper = 13
mid = (lower + upper)/2
TH = 11

plt.text(lower, -0.8, r'$\tilde{t}_{Lower}$')
plt.text(upper, -0.8, r'$\tilde t_{Upper}$')
plt.text(mid, -0.8, r'$\tilde t_{Mid}$')
plt.text(TH, -0.8, r'$\tilde t_{TH}$')

plt.text(15.5, -0.8, r'$\tilde t$')
plt.text(-2, 10, r'$f^*\left(\tilde t, \lambda \right)$')

plt.annotate('Max', xy=(10.1, f(10)+0.1), xytext=(11, f(10)+1),
            arrowprops=dict(facecolor='red', shrink=0.05),
            )
# plt.text(3, 8.8, 'Optimal')
# dots
value_lower = f(lower)
value_upper = f(upper)

value_mid = f(mid)


plt.scatter([lower, upper, lower, mid, mid], [0, 0, value_lower, 0, value_mid], color='black', linewidth=2)
plt.scatter(10, f(10), color='red', linewidth=2)

plt.plot([lower, lower], [0, value_lower], color='black', linestyle='--')
# plt.plot([upper, upper], [0, value_upper], color='black', linestyle='--')
plt.plot([mid, mid], [0, value_mid], color='black', linestyle='--')

# for threshold
plt.plot([TH, TH], [0, f(TH)], color='black', linestyle='--')
plt.scatter([TH, TH], [0, f(TH)], color='white', s=30, edgecolors='black')

plt.box(on=None)
plt.gca().axes.get_xaxis().set_visible(False)
plt.gca().axes.get_yaxis().set_visible(False)

plt.axhline(0, color='black')
plt.axvline(0, color='black')
plt.show()
