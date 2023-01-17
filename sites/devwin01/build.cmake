#############################################
# Site-Specific Build Configuration Script  #
#############################################
#
# This script should be edited for each new site where
# we want to build ITK-SNAP and related tools. The
# general structure of this script should be followed on
# all sites, but some additonal variables (e.g., CTEST_ENVIRONMENT)
# may need to be set on some platforms and configurations

# This site uploads its builds
SETCOND(DO_UPLOAD ON CONFIG "vce64rel")

# Library directory: path where all the libraries are build (this is only used internally)
SET(TKDIR "${HOME}/../tk")

# Set SNAP test acceleration factor
CACHE_ADD("SNAP_GUI_TEST_ACCEL:STRING=1" PRODUCT itksnap)

# This compiler cannot handle old VTK versions
SETCOND(SKIP_BUILD ON PRODUCT itk BRANCH v4.2.1)
SETCOND(SKIP_BUILD ON PRODUCT vtk BRANCH v5.8.0)

# Directory shortcuts
SET(MYBIN "bin64")
SET(VCVER "vce22")

# These cache entries are configuration specific. I ran cmake gui from the VC prompt with Nmake as the 
# build system to generate these
SET(VCBINDIR64 "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.34.31933/bin/Hostx64/x64")
CACHE_ADD("CMAKE_C_COMPILER:FILEPATH=${VCBINDIR64}/cl.exe")
CACHE_ADD("CMAKE_CXX_COMPILER:FILEPATH=${VCBINDIR64}/cl.exe")
CACHE_ADD("CMAKE_TOOLCHAIN_FILE:FILEPATH=C:/tk/vcpkg/scripts/buildsystems/vcpkg.cmake")

# CACHE_ADD("VCREDIST_EXE:FILEPATH=C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Redist/MSVC/14.29.30133/vcredist_x64.exe")

# Curl directory
SET(CURLDIR "C:/tk/vcpkg/packages/curl_x64-windows")
CACHE_ADD("CURL_LIBRARY:FILEPATH=${CURLDIR}/lib/libcurl.lib" PRODUCT itksnap)
CACHE_ADD("CURL_INCLUDE_DIR:PATH=${CURLDIR}/include" PRODUCT itksnap)

# Set the Generator
SET(CTEST_CMAKE_GENERATOR "NMake Makefiles JOM")
# SET(CTEST_CMAKE_GENERATOR "Ninja")


# Add JOM to the path
ENV_ADD(PATH "${TKDIR}/jom_1_1_3;$ENV{PATH}")
# SET(NINJA_DIR "C:/tk/Qt/Tools/Ninja")
# ENV_ADD(PATH "${NINJA_DIR};$ENV{PATH}")

# Add cache entries
CACHE_ADD("ITK_SKIP_PATH_LENGTH_CHECKS:BOOL=ON")
# CACHE_ADD("CMAKE_MAKE_PROGRAM:FILEPATH=${NINJA_DIR}/ninja.exe")
# CACHE_ADD("MAKECOMMAND:STRING=ninja.exe")
CACHE_ADD("CMAKE_MAKE_PROGRAM:FILEPATH=${TKDIR}/jom_1_1_3/jom.exe")
CACHE_ADD("MAKECOMMAND:STRING=jom.exe -i -j 24")
CACHE_ADD("BUILDNAME:STRING=Win11-${VCVER}-${IN_CONFIG}")
CACHE_ADD("SITE:STRING=devwin01")
CACHE_ADD("CMAKE_BUILD_TYPE:STRING=Release" CONFIG .*rel.*)
CACHE_ADD("CMAKE_BUILD_TYPE:STRING=Debug" CONFIG .*dbg.*)
CACHE_ADD("SCP_PROGRAM:STRING=C:/Program Files/Git/usr/bin/scp.exe")
CACHE_ADD("CMAKE_C_FLAGS:STRING=/DWIN32 /D_WINDOWS /W3")
#CACHE_ADD("CMAKE_CXX_FLAGS:STRING=/DWIN32 /D_WINDOWS /W3 /GR /EHsc")
#CACHE_ADD("CMAKE_RC_COMPILER:FILEPATH=${SDKBINDIR}/RC.Exe")

# Add product-specific cache entries

MESSAGE(STATUS "Product: ${IN_PRODUCT}")
IF(${IN_PRODUCT} MATCHES vtk)
  CACHE_ADD("CMAKE_CXX_FLAGS:STRING=/DWIN32 /D_WINDOWS /W3 /GR /EHsc /DNOMINMAX")
ELSE()
  CACHE_ADD("CMAKE_CXX_FLAGS:STRING=/DWIN32 /D_WINDOWS /W3 /GR /EHsc /DNOMINMAX /std:c++17 /permissive-")
ENDIF()

IF(NEED_QT4)
  CACHE_ADD("QT_QMAKE_EXECUTABLE:FILEPATH=E:/tk/Qt48/msvc2013_64/bin/qmake.exe")
ELSEIF(NEED_QT5)
  SETCOND(SKIP_BUILD ON)
ELSEIF(NEED_QT54)
  SETCOND(SKIP_BUILD ON  CONFIG vce32.*)
ELSEIF(NEED_QT56)
  SETCOND(SKIP_BUILD ON  CONFIG vce32.*)
ELSEIF(NEED_QT515)
  SETCOND(SKIP_BUILD ON  CONFIG vce32.*)
ELSEIF(NEED_QT6)
  SETCOND(SKIP_BUILD ON  CONFIG vce32.*)
  SETCOND(QT6_PATH "C:/tk/Qt/6.2.4/msvc2019_64/lib/cmake" CONFIG vce64.*)
  CACHE_ADD("CMAKE_PREFIX_PATH:FILEPATH=${QT6_PATH}")
ENDIF(NEED_QT4)

# C3D specific settings
CACHE_ADD("BUILD_GUI:BOOLEAN=ON" PRODUCT "c3d")