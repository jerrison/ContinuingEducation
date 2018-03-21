
# coding: utf-8

# In[1]:


import math


# In[2]:


def polysum(n, s):
    area = (0.25 * n * s**2) / (math.tan(math.pi / n))
    perimeter = n * s
    return round(area + perimeter**2, 4)
