# prepare data for python modelling

source("setup.R")
library(reticulate)

r_model = readRDS("data/models/m03_classification.RDS")


X = r_model$trainingData
y = X %>% pull(.outcome)
X = X %>% dplyr::select(-.outcome)

feature_names = colnames(X)
target_names = levels(y)

X = as.matrix(X)
attr(X, "dimnames") = NULL





# switch to python

skl_rf = import("sklearn.ensemble")

py_X = r_to_py(X)
py_y = r_to_py(y)

py_feature_names = r_to_py(feature_names)
py_target_names = r_to_py(target_names)




# n_estimatirs = number of trees

clf = skl_rf$RandomForestClassifier(n_estimators = as.integer(20),
                                    max_depth = as.integer(3),
                                    max_leaf_nodes = as.integer(5),
                                    bootstrap = FALSE,
                                    criterion = "gini")

model = clf$fit( X = py_X, y = py_y )



exmatrix = import("exmatrix")
np = import("numpy")


exm = exmatrix$ExplainableMatrix(n_features = length( feature_names ),
                                 n_classes = length( target_names ),
                                 feature_names = np$array(py_feature_names),
                                 class_names = np$array(py_target_names) )


exm$rule_extration( clf, py_X, py_y, clf$feature_importances_ )


exp = exm$explanation( info_text = 'ntrees=20' )
exp$create_svg( draw_row_labels = TRUE, draw_col_labels = TRUE, draw_rows_line = TRUE, draw_cols_line = TRUE, col_label_degrees = as.integer(10), width = as.integer(1990), height = as.integer(2500), margin_bottom = as.integer(150) )

exp$save( 'python/plots/lcc_globalExplanation.png', pixel_scale = 5 )
exp$save( 'python/plots/lcc_globalExplanation.svg' )



exp = exm$explanation( exp_type = 'local-used', x_k = py_X[ 150], r_order = 'coverage', f_order = 'importance', info_text = '\ninstance 150\n' )
exp$create_svg( draw_row_labels = TRUE, draw_col_labels = TRUE, draw_rows_line = TRUE, draw_cols_line = TRUE, col_label_degrees = as.integer(10), width = as.integer(1990), height = as.integer(940), margin_bottom = as.integer(150) )
exp$save( 'python/plots/lcc-150.png', pixel_scale = 5 )
exp$save( 'python/plots/lcc-150.svg' )



exp = exm$explanation( exp_type = 'local-used', x_k = py_X[2000], r_order = 'coverage', f_order = 'importance', info_text = '\ninstance 2000\n' )
exp$create_svg( draw_row_labels = TRUE, draw_col_labels = TRUE, draw_rows_line = TRUE, draw_cols_line = TRUE, col_label_degrees = as.integer(10), width = as.integer(1990), height = as.integer(940), margin_bottom = as.integer(150) )
exp$save( 'python/plots/lcc-2000.png', pixel_scale = 5 )
exp$save( 'python/plots/lcc-2000.svg' )



exp = exm$explanation( exp_type = 'local-used', x_k = py_X[3000], r_order = 'coverage', f_order = 'importance', info_text = '\ninstance 3000\n' )
exp$create_svg( draw_row_labels = TRUE, draw_col_labels = TRUE, draw_rows_line = TRUE, draw_cols_line = TRUE, col_label_degrees = as.integer(10), width = as.integer(1990), height = as.integer(940), margin_bottom = as.integer(150) )
exp$save( 'python/plots/lcc-3000.png', pixel_scale = 5 )
exp$save( 'python/plots/lcc-3000.svg' )
