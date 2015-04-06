# DESCRIBE THE PRODUCT
SET(PRODUCT_CHECKOUT_COMMAND 
  "${GIT_BINARY} clone -b ${IN_BRANCH} ssh://${GIT_UID}@git.code.sf.net/p/itk-snap/src ${IN_PRODUCT}")

# SET UP PRODUCT-SPECIFIC CACHE ENTRIES
CACHE_ADD("ITK_DIR:PATH=${ROOT}/Nightly/itk/v4.2.1/${IN_CONFIG}" BRANCH "rel_2.4")
CACHE_ADD("ITK_DIR:PATH=${ROOT}/Nightly/itk/v4.5.2/${IN_CONFIG}" BRANCH "rel_3.2")
CACHE_ADD("ITK_DIR:PATH=${ROOT}/Nightly/itk/v4.5.2/${IN_CONFIG}" BRANCH "master")

CACHE_ADD("VTK_DIR:PATH=${ROOT}/Nightly/vtk/v5.8.0/${IN_CONFIG}" BRANCH "rel_2.4")
CACHE_ADD("VTK_DIR:PATH=${ROOT}/Nightly/vtk/v6.1.0/${IN_CONFIG}" BRANCH "rel_3.2")
CACHE_ADD("VTK_DIR:PATH=${ROOT}/Nightly/vtk/v6.1.0/${IN_CONFIG}" BRANCH "master")

# SPECIFY which products we need
SETCOND(NEED_FLTK ON BRANCH "rel_2.4")
SETCOND(NEED_QT5 ON BRANCH "rel_3.2")
SETCOND(NEED_QT54 ON BRANCH "master")
