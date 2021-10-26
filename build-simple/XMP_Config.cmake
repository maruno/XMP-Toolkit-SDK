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

# ==============================================================================
# XMP config for XMPTOOLKIT and TestRunner
# ==============================================================================
if(NOT DEFINED XMP_ROOT)
	set(XMP_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/${XMP_THIS_PROJECT_RELATIVEPATH})
endif()
if(NOT DEFINED COMMON_BUILD_SHARED_DIR)
	set(COMMON_BUILD_SHARED_DIR ${XMP_ROOT}/build/shared)
endif()

if(NOT DEFINED INCLUDE_CPP_DOM_SOURCE)
	set(INCLUDE_CPP_DOM_SOURCE TRUE)
endif()

if (INCLUDE_CPP_DOM_SOURCE)
	add_definitions(-DENABLE_CPP_DOM_MODEL=1)
else (INCLUDE_CPP_DOM_SOURCE)
	add_definitions(-DENABLE_CPP_DOM_MODEL=0)
endif(INCLUDE_CPP_DOM_SOURCE)

#add definition specific to XMP and shared by all projects
add_definitions(-DXML_STATIC=1 -DHAVE_EXPAT_CONFIG_H=1 )
if(XMP_BUILD_STATIC)
	add_definitions(-DXMP_StaticBuild=1)
else()
	add_definitions(-DXMP_DynamicBuild=1)
endif()

function(AddMacFramework appname fwname)
	# ignore on simple builds
endfunction(AddMacFramework)

function(SetPlatformLinkFlags target linkflags libname)
	set_target_properties(${target} PROPERTIES LINK_FLAGS "${XMP_PLATFORM_LINK} ${linkflags}")
endfunction(SetPlatformLinkFlags)

include(${XMP_ROOT}/build-simple/ProductConfig.cmake)
include(${XMP_ROOT}/build-simple/XMP_ConfigCommon.cmake)
include(${XMP_ROOT}/build/shared/SharedConfig_Common.cmake)
SetupTargetArchitecture()
SetupInternalBuildDirectory()

include(${XMP_ROOT}/build/shared/SharedConfig_Linux.cmake)
