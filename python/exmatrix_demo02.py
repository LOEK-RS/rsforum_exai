from exmatrix import ExplainableMatrix

exm = ExplainableMatrix( n_features = len( feature_names ), n_classes = len( target_names ), feature_names = np.array( feature_names ), class_names = np.array( target_names ) )
exm.rule_extration( clf, X, y, clf.feature_importances_ )
print( 'n_rules RF-3', exm.n_rules_ )


exp = exm.explanation( info_text = '\ntrees 3\nmax-depth 3\n\naccuracy 0.96\nerror 0.04\n' )
exp.create_svg( draw_row_labels = True, draw_col_labels = True, draw_rows_line = True, draw_cols_line = True, col_label_degrees = 10, width = 1990, height = 940, margin_bottom = 150 )
exp.save( 'python/plots/IrisFlowerGE.png', pixel_scale = 5 )
exp.save( 'python/plots/IrisFlowerGE.svg' )




exp = exm.explanation( exp_type = 'local-used', x_k = X_test[ 13 ], r_order = 'coverage', f_order = 'importance', info_text = '\ninstance 13\n' )
exp.create_svg( draw_x_k = True, draw_row_labels = True, draw_col_labels = True, draw_rows_line = True, draw_cols_line = True, col_label_degrees = 10, width = 1890, height = 720, margin_bottom = 150 )
exp.save( 'python/plots/IrisFlowerLEUR-13.png', pixel_scale = 5 )
exp.save( 'python/plots/IrisFlowerLEUR-13.svg' )



exp = exm.explanation( exp_type = 'local-closest', x_k = X_test[ 13 ], r_order = 'delta change', f_order = 'importance', info_text = '\ninstance 13\n' )
exp.create_svg( draw_x_k = True, draw_deltas = True, cell_background = True, draw_row_labels = True, draw_col_labels = True, draw_rows_line = True, draw_cols_line = True, col_label_degrees = 10, width = 1890, height = 720, margin_bottom = 150 )
exp.save( 'python/plots/IrisFlowerLESC-13.png', pixel_scale = 5 )
exp.save( 'python/plots/IrisFlowerLESC-13.svg' )
