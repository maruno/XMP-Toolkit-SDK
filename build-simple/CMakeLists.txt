# =================================================================================================
# ADOBE SYSTEMS INCORPORATED
# Copyright 2013 Adobe Systems Incorporated
# All Rights Reserved
#
# NOTICE: Adobe permits you to use, modify, and distribute this file in accordance with the terms
# of the Adobe license agreement accompanying it.
# =================================================================================================
  
# ==============================================================================
# define minimum cmake version
# For Android always build with make 3.6
if(ANDROID)
	cmake_minimum_required(VERSION 3.5.2)
else(ANDROID)
	cmake_minimum_required(VERSION 3.15.5)
endif(ANDROID)


# Fetch dependencies
include(FetchContent)

# Expat XML parser
message("-- Declaring for fetch: libexpat")
FetchContent_Declare(
  expat
  GIT_REPOSITORY "https://github.com/libexpat/libexpat"
  GIT_TAG "R_2_4_1"
  SOURCE_SUBDIR "expat")

# Zlib
message("-- Declaring for fetch: zlib")
FetchContent_Declare(
  zlib
  GIT_REPOSITORY "https://github.com/madler/zlib"
  GIT_TAG "v1.2.11")

FetchContent_MakeAvailable(expat zlib)
set(TP_EXPAT_PATH ${expat_SOURCE_DIR}/expat/)

# Enable folder grouping of projects in IDEs
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# ==============================================================================
# This project
option(XMP_BUILD_STATIC "Build static?" ON)
option(CMAKE_CL_64 "64bit target?" OFF)
set(TARGET_NAME XMPToolkitSDK)
SET(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "Configurations" FORCE)
if(CMAKE_CL_64)
	project(${TARGET_NAME}64)
else(CMAKE_CL_64)
	project(${TARGET_NAME})
endif(CMAKE_CL_64)

if(NOT DEFINED XMP_TOPLEVELPROJECT)
	set(XMP_TOPLEVELPROJECT "XMPBuild" CACHE INTERNAL "Identify top level project responsible for build XMP libs")
endif()

# ==============================================================================
# Globals
# ==============================================================================

set(XMP_ROOT ${PROJECT_SOURCE_DIR}/..)

# ==============================================================================
# SET XMP and Plugin Version Numbers defined in an external file
# ==============================================================================

# Get Version numbers from an external file XMP_BuildNumber.txt
#file(STRINGS "XMP_BuildNumber.txt" XMP_BUILD_STRING) 

# Parse List for Minor Major and Branchnumber
#string(REGEX MATCHALL "[0-9]" XMP_BUILD_VERSION_LIST "${XMP_BUILD_STRING}")
#list(GET XMP_BUILD_VERSION_LIST 0 XMP_VERSION_MAJOR)
#list(GET XMP_BUILD_VERSION_LIST 1 XMP_VERSION_MINOR)
#list(GET XMP_BUILD_VERSION_LIST 2 XMP_BRANCH_NUMBER)
	
#set(XMP_VERSION ${XMP_VERSION_MAJOR}.${XMP_VERSION_MINOR}.${XMP_BRANCH_NUMBER})

# Write the Version infos to a header file
#configure_file (
#  "${XMP_ROOT}/../toolkit/build/XMP_VersionNumber.h.in"
#  "${XMP_ROOT}/../toolkit/public/include/XMP_VersionNumber.h"
#  )
  
# extract BUILDID from XMP_BuildInfo.h to be used by external CMake files, e.g. FaceDetector DLL
#file(STRINGS "XMP_BuildInfo.h" XMP_BUILDID_LINE REGEX "#define BUILDID ")
#string(REGEX MATCHALL "[0-9]+" XMP_BUILDID ${XMP_BUILDID_LINE})

set(OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR})

# ==============================================================================
# Shared config
# ==============================================================================
# setup some values before calling shared config
include(${XMP_ROOT}/build-simple/XMP_Config.cmake)
include(${XMP_ROOT}/build/shared/SharedConfig_Common.cmake)

# ==============================================================================
# Sub projects
# ==============================================================================
add_subdirectory(${XMP_ROOT}/XMPCore/build-simple ${XMP_ROOT}/XMPCore/build/${XMP_CMAKEFOLDER_NAME})
add_subdirectory(${XMP_ROOT}/XMPFiles/build-simple ${XMP_ROOT}/XMPFiles/build/${XMP_CMAKEFOLDER_NAME})


# ==============================================================================
# configuration feedback
# ==============================================================================

message (STATUS "===========================================================================")
message (STATUS " ${TARGET_NAME} ")
#message (STATUS " Version = ${XMP_VERSION}")
message (STATUS "===========================================================================")
#message (STATUS " ${XMP_EXTRA_BUILDMACHINE}")
message (STATUS " 64 bit build is: ${CMAKE_CL_64}")
message (STATUS " Static build is: ${XMP_BUILD_STATIC}")
message (STATUS " ${TARGET_NAME} ")
message (STATUS " ${XMP_PLATFORM_LINK} ")
message (STATUS " ${XMP_GLOBALS}")
message (STATUS " Compiler: ")
message (STATUS " CC=${CMAKE_C_COMPILER}")
message (STATUS " CXX=${CMAKE_CXX_COMPILER}")

#disable cmake warning "Manually-specified variables were not used by the project"
set(ignore "${CMAKE_CL_64}${CMAKE_BUILD_TYPE}${XMP_CMAKEFOLDER_NAME}${CMAKE_TOOLCHAIN_FILE}${CMAKE_LIBCPP}${XMP_BUILD_WARNING_AS_ERROR}") 
message (STATUS "===========================================================================")
