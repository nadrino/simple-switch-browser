# Licensed under the MIT license.
# Refer to the LICENSE file included.
#
# libnx CMake template for Nintendo Switch homebrew development.
cmake_minimum_required(VERSION 3.1)

project(SimpleSwitchBrowser)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set (VERSION_MAJOR 0)
set (VERSION_MINOR 0)
set (VERSION_MICRO 1)
set (VERSION_TAG f) # f means forward -> include commits after a given release
set (VERSION_STRING
        "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_MICRO}${VERSION_TAG}")
set (APP_VERSION ${VERSION_STRING})
configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/cmake/VersionConfig.h.in ${CMAKE_BINARY_DIR}/generated/VersionConfig.h )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 20)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    include(clang-utils)
endif ()


include(options)
include(utils)
include(devkita64-libnx)
include(nx-utils)
include(dependencies)

# Submodules
set(SUBMODULES_DIR ${PROJECT_SOURCE_DIR}/submodules)
include_directories( ${SUBMODULES_DIR}/cpp-generic-toolbox/include )

include_directories( ${SUBMODULES_DIR}/simple-cpp-logger/include )
add_definitions( -D LOGGER_MAX_LOG_LEVEL_PRINTED=6 )
add_definitions( -D LOGGER_PREFIX_LEVEL=3 )
add_definitions( -D LOGGER_ENABLE_COLORS_ON_USER_HEADER=1 )
add_definitions( -D LOGGER_TIME_FORMAT="\\\"%d/%m/%Y %H:%M:%S"\\\" )
add_definitions( -D LOGGER_PREFIX_FORMAT="\\\"{TIME} {USER_HEADER} {FILELINE}"\\\" )

include(borealis)

# Auto Generated
configure_file(VersionConfig.h.in ${CMAKE_BINARY_DIR}/generated/VersionConfig.h )
include_directories( ${CMAKE_BINARY_DIR}/generated/ )

# This project
include(src/CMakeLists.txt)

