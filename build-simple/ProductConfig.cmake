#// =================================================================================================
#// Copyright 2020 Adobe
#// All Rights Reserved.
#// NOTICE: Adobe permits you to use, modify, and distribute this file in
#// accordance with the terms of the Adobe license agreement accompanying
#// it. 
#// =================================================================================================

# ==============================================================================
# define minimum cmake version
# For Android always build with make 3.6
if(ANDROID)
	cmake_minimum_required(VERSION 3.5.2)
else(ANDROID)
	cmake_minimum_required(VERSION 3.15.5)
endif(ANDROID)

# ==============================================================================
# Product Config for XMP Toolkit
# ==============================================================================

if(CMAKE_CROSSCOMPILING)
	set(XMP_EXTRA_BUILDMACHINE	"Cross Compiling")
elseif (${CMAKE_SYSTEM_PROCESSOR} MATCHES "x86_64")
	# running on 64bit machine
	set(XMP_EXTRA_BUILDMACHINE	"Buildmachine is 64bit")
else()
	# running on 32bit machine
	set(XMP_EXTRA_BUILDMACHINE	"Buildmachine is 32bit")
endif()

if(CMAKE_CL_64)
	set(XMP_EXTRA_COMPILE_FLAGS "-m64")
	set(XMP_EXTRA_LINK_FLAGS "-m64")
	set(XMP_PLATFORM_FOLDER "generic64") # add XMP_BUILDMODE_DIR to follow what other platforms do
else()
	set(XMP_EXTRA_LINK_FLAGS "-m32")
	set(XMP_PLATFORM_FOLDER "generic") # add XMP_BUILDMODE_DIR to follow what other platforms do
endif()

set(XMP_PLATFORM_VERSION "generic1.0") # add XMP_BUILDMODE_DIR to follow what other platforms do

add_definitions(-DUNIX_ENV=1)
set(XMP_PLATFORM_SHORT "generic")

set(XMP_PLATFORM_LINK " -lc++abi ${XMP_PLATFORM_LINK}")
set(XMP_SHARED_COMPILE_FLAGS "-Wno-multichar -D_FILE_OFFSET_BITS=64 -funsigned-char  ${XMP_EXTRA_COMPILE_FLAGS} ${XMP_TOOLCHAIN_COMPILE_FLAGS}")

set(XMP_SHARED_COMPILE_DEBUG_FLAGS " ")
set(XMP_SHARED_COMPILE_RELEASE_FLAGS "-fwrapv ")
