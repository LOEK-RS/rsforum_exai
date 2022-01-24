library(reticulate)


reticulate::install_miniconda()
conda_list()

use_miniconda("r-reticulate", required = TRUE)

conda_install(envname = "r-reticulate", packages = "exmatrix", pip = TRUE)
conda_install(envname = "r-reticulate", packages = "sklearn", pip = TRUE)
conda_install(envname = "r-reticulate", packages = "scikit-learn", pip = TRUE)
conda_install(envname = "r-reticulate", packages = "numpy", pip = TRUE)

source_python("python/exmatrix_demo01.py")
source_python("python/exmatrix_demo02.py")


