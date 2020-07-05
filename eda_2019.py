import pandas as pd
from matplotlib import pyplot as plt
import numpy as np
from sklearn.model_selection import train_test_split

df = pd.read_csv("/Users/jakeberberian/fantasy-football/data/2019.csv")

print(df.head())
print(df.shape)

df = df.loc[df['Pos'] == 'RB', ['Player', 'Tgt', 'RushingAtt', 'FantasyPoints']]
df['Usage'] = df['Tgt'] + df['RushingAtt']
print(df)

# Let's create a "usage" metric so we can see what RBs get the most action.
df['UsageRank'] = df['Usage'].rank(ascending=False)
df['FantasyPointsRank'] = df['FantasyPoints'].rank(ascending=False)
print(df.sort_values(by='UsageRank').head(15))

plt.style.use('ggplot')
df.plot(x='Usage', y='FantasyPoints', kind='scatter')
plt.show()


# Write a function to define covariance
def covariance(x, y):
    n = len(x)
    return sum((x - np.mean(x)) * (y - np.mean(y))) * 1 / (n - 1)

# Now set variables for covariance calculation.
x = df['Usage'].values
y = df['FantasyPoints'].values

# Let's try out our function

print("Covariance:", covariance(x, y))

def corr(x, y):
    return covariance(x, y)/(np.std(x) * np.std(y))

print("Correlation:" ,corr(x, y))

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size = 0.2)
x_train[:20]
