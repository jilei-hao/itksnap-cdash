# DESCRIBE THE PRODUCT
SET(PRODUCT_CHECKOUT_COMMAND 
  "${GIT_BINARY} clone -b ${IN_BRANCH} --recursive ssh://${GIT_UID}@git.code.sf.net/p/itk-snap/src ${IN_PRODUCT}")

# Check if a Qt 4.x build is requested
IF(${CONFIG_EXT} MATCHES ".*qt4.*")

  # This should not be requested for old branches
  SETCOND(SKIP_BUILD ON BRANCH rel_2.4)
  SETCOND(SKIP_BUILD ON BRANCH rel_3.2)

  # Set the cache entry
  CACHE_ADD("SNAP_USE_QT4:BOOLEAN=ON")

  # Request Qt4
  SET(NEED_QT4 ON)
  SET(NEED_FLTK OFF)
  SET(NEED_QT5 OFF)
  SET(NEED_QT54 OFF)

ELSE(${CONFIG_EXT} MATCHES ".*qt4.*")

  # SPECIFY which products we need
  SET(NEED_QT4 OFF)
  SETCOND(NEED_FLTK ON BRANCH "rel_2.4")
  SETCOND(NEED_QT5 ON BRANCH "rel_3.2")
  SETCOND(NEED_QT54 ON BRANCH "rel_3.4")
  SETCOND(NEED_QT54 ON BRANCH "master")

ENDIF(${CONFIG_EXT} MATCHES ".*qt4.*")

# SET UP PRODUCT-SPECIFIC CACHE ENTRIES
CACHE_ADD("ITK_DIR:PATH=${ROOT}/Nightly/itk/v4.2.1/${CONFIG_BASE}" BRANCH "rel_2.4")
CACHE_ADD("ITK_DIR:PATH=${ROOT}/Nightly/itk/v4.5.2/${CONFIG_BASE}" BRANCH "rel_3.2")
CACHE_ADD("ITK_DIR:PATH=${ROOT}/Nightly/itk/v4.5.2/${CONFIG_BASE}" BRANCH "rel_3.4")
CACHE_ADD("ITK_DIR:PATH=${ROOT}/Nightly/itk/v4.8.2/${CONFIG_BASE}" BRANCH "master")

CACHE_ADD("VTK_DIR:PATH=${ROOT}/Nightly/vtk/v5.8.0/${CONFIG_BASE}" BRANCH "rel_2.4")
CACHE_ADD("VTK_DIR:PATH=${ROOT}/Nightly/vtk/v6.1.0/${CONFIG_BASE}" BRANCH "rel_3.2")
CACHE_ADD("VTK_DIR:PATH=${ROOT}/Nightly/vtk/v6.1.0/${CONFIG_BASE}" BRANCH "rel_3.4")
CACHE_ADD("VTK_DIR:PATH=${ROOT}/Nightly/vtk/v6.3.0/${CONFIG_BASE}" BRANCH "master")
