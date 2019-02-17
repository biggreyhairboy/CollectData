import matplotlib.pyplot as plt
import numpy as np

fig = plt.figure();
ax = fig.add_subplot(1, 1, 1)
ax.plot(np.random.randn(1000).cumsum())
fig.show()

ticks = ax.set_xticks([0, 250, 500, 750, 1000])
# labes = ax.set_xticklabels(['one', 'two', 'three', 'four', 'five'], rotation=30, fontsize='small')
ax.set_title('My first matplotlib figure')
ax.set_xlabel('Stages')

print('h')