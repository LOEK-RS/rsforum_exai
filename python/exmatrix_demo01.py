import numpy as np
import sklearn.datasets as datasets
from sklearn.model_selection import StratifiedShuffleSplit
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score


dataset = datasets.load_iris()

X = dataset.data
y = dataset.target

feature_names = dataset.feature_names
target_names = dataset.target_names


sss = list( StratifiedShuffleSplit( n_splits = 1, test_size = 0.30, random_state = 68269 ).split( X, y ) )
train_indexes = sss[ 0 ][ 0 ]
test_indexes = sss[ 0 ][ 1 ]

X_train, X_test = X[ train_indexes ], X[ test_indexes ]
y_train, y_test = y[ train_indexes ], y[ test_indexes ]


kargs = eval( "{'criterion': 'gini', 'n_estimators': 3, 'max_depth': 3, 'max_leaf_nodes': 4, 'random_state': 68269, 'bootstrap': False}" )
clf = RandomForestClassifier( **kargs )
clf.fit( X_train, y_train )


y_true, y_pred = y_test, clf.predict( X_test )
accuracy = accuracy_score( y_true, y_pred )
print( 'accuracy RF-3', accuracy )
