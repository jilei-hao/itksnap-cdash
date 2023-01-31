#! /bin/bash

/usr/local/bin/ctest -VV \
  -D PRODUCT_MASK:STRING="ITK-SNAP" \
  -D SKIP_EXTERNAL:BOOL=NO \
  -D FORCE_CLEAN:BOOL=NO \
  -D SKIP_TESTING:BOOL=NO \
  -D FORCE_CONTINUOUS:BOOL=NO \
  -D GIT_BINARY:STRING="/usr/local/bin/git" \
  -D GIT_UID:STRING="jilei-hao" \
  -D CONFIG_LIST:STRING="xc64rel;xc64rel-x86_64" \
  -D CMAKE_BINARY_PATH:PATH="/usr/local/bin" \
  -D IN_GLOBAL_MODEL:STRING="Experimental" \
  -D IN_SITE:STRING="devmac01" \
  -S ./build_robot.cmake