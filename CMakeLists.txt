cmake_minimum_required (VERSION 3.5 FATAL_ERROR)

# ------------------
# Configure CMake project
# ------------------
project(SimpleSwitchBrowser)
set (SimpleSwitchBrowser_VERSION_MAJOR 0)
set (SimpleSwitchBrowser_VERSION_MINOR 0)
set (SimpleSwitchBrowser_VERSION_REVISION 1)
set (SimpleSwitchBrowser_VERSION_TAG f) # f means forward -> include commits after a given release
set (SimpleSwitchBrowser_VERSION_STRING
        "${SimpleSwitchBrowser_VERSION_MAJOR}.${SimpleSwitchBrowser_VERSION_MINOR}.${SimpleSwitchBrowser_VERSION_REVISION}${SimpleSwitchBrowser_VERSION_TAG}")
set (APP_VERSION ${SimpleSwitchBrowser_VERSION_STRING})
configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/cmake/VersionConfig.h.in ${CMAKE_BINARY_DIR}/generated/VersionConfig.h )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)


# ------------------
# CMake includes
# ------------------
include(options)
include(utils)
include(nx-utils)

cmake_info("Building ${APP_TITLE} version ${SimpleSwitchBrowser_VERSION_STRING}.")

#set(CMAKE_CXX_STANDARD 17)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_CXX_EXTENSIONS OFF)
#set(CMAKE_C_FLAGS "-Wno-unused-variable -std=gnu++17")
#set(CMAKE_CXX_FLAGS "-Wno-unused-variable -std=gnu++17")


# ------------------
# Submodules
# ------------------
set(SUBMODULES_DIR ${PROJECT_SOURCE_DIR}/submodules)

# ------------------
# Dependencies
# ------------------
find_package(LIBNX REQUIRED)
if (NOT LIBNX_FOUND)
    cmake_panic("Unable to detect libnx on this system.")
endif()
#
#find_package(ZLIB REQUIRED)
#if (${ZLIB_FOUND})
#    message("ZLIB found : ${ZLIB_VERSION_STRING}")
#    message("ZLIB_INCLUDE_DIRS = ${ZLIB_INCLUDE_DIRS}")
#    message("ZLIB_LIBRARIES = ${ZLIB_LIBRARIES}")
#else()
#    message(FATAL_ERROR "ZLIB has not been found.")
#endif ()
#
#find_package(Freetype REQUIRED)
#if (${FREETYPE_FOUND})
#    message("Freetype found : ${FREETYPE_VERSION_STRING}")
#    message("FREETYPE_INCLUDE_DIRS = ${FREETYPE_INCLUDE_DIRS}")
#    message("FREETYPE_LIBRARIES = ${FREETYPE_LIBRARIES}")
#else()
#    message(FATAL_ERROR "FREETYPE has not been found.")
#endif ()
#
#
#find_package(BZip2 REQUIRED)
#if (${BZIP2_FOUND})
#    message("BZIP2 found : ${BZIP2_VERSION_STRING}")
#    message("BZIP2_INCLUDE_DIRS = ${BZIP2_INCLUDE_DIRS}")
#    message("BZIP2_LIBRARIES = ${BZIP2_LIBRARIES}")
#else()
#    message(FATAL_ERROR "BZIP2 has not been found.")
#endif ()
#
#include_directories("${ZLIB_INCLUDE_DIRS}")
#include_directories("${FREETYPE_INCLUDE_DIRS}")
##include_directories("${SDL2_INCLUDE_DIRS}")

if (NOT DEFINED CMAKE_BUILD_TYPE_INIT)
    set(CMAKE_BUILD_TYPE_INIT Release)
endif ()

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    include(clang-utils)
endif ()


# ------------------
# Borealis Lib
# ------------------
set(BOREALIS_DIR ${SUBMODULES_DIR}/borealis)
#add_compile_definitions(BOREALIS_RESOURCES=\"romfs:/borealis/\")
cmake_info("BOREALIS_DIR is ${BOREALIS_DIR}")
set(BOREALIS_INC_DIR ${BOREALIS_DIR}/library/include)

set( BOREALIS_RESOURCES "romfs:/" )
add_definitions( -D BRLS_RESOURCES=\\\"${BOREALIS_RESOURCES}\\\" )

add_definitions( -D YG_ENABLE_EVENTS )


# ------------------
# Meta information about the app
# ------------------
set(APP_NAME SimpleSwitchBrowser)
set(APP_TITLE ${APP_NAME})
set(APP_AUTHOR "Nadrino")
set(APP_ICON "${CMAKE_CURRENT_SOURCE_DIR}/assets/icon_gui.jpg")
set(APP_ROMFS "${CMAKE_CURRENT_SOURCE_DIR}/resources")


# ------------------
# Includes
# ------------------
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/include")
include_directories("${SUBMODULES_DIR}/cpp-generic-toolbox/include")
include_directories("${SUBMODULES_DIR}/simple-cpp-logger/include")
include_directories("${CMAKE_BINARY_DIR}/generated/")

include_directories("${PORTLIBS}/include")
include_directories("${LIBNX}/include")

include_directories("${BOREALIS_INC_DIR}")

include_directories("${BOREALIS_DIR}/library/lib/extern/fmt/include")
include_directories("${BOREALIS_DIR}/library/lib/extern/yoga/src")
include_directories("${BOREALIS_DIR}/library/lib/extern/nanovg-deko3d/include")
include_directories("${BOREALIS_DIR}/library/lib/extern/tweeny/include")

include_directories("${BOREALIS_INC_DIR}/borealis/extern")
include_directories("${BOREALIS_INC_DIR}/borealis/extern/tinyxml2")

include_directories("${BOREALIS_DIR}/library/lib/extern/switch-libpulsar/include")





file(
        GLOB BOREALIS_SOURCE_FILES
        # library itself:
        "${BOREALIS_DIR}/library/lib/core/*.cpp"
        "${BOREALIS_DIR}/library/lib/views/*.cpp"
        "${BOREALIS_DIR}/library/lib/platforms/switch/switch_*.cpp"

        # glad
        "${BOREALIS_DIR}/library/lib/extern/glad/*.c"

        # nanovg source files
        "${BOREALIS_DIR}/library/lib/extern/nanovg-deko3d/source/*.c*"
        "${BOREALIS_DIR}/library/lib/extern/nanovg-deko3d/source/framework/*.c*"
        "${BOREALIS_DIR}/library/lib/extern/nanovg-deko3d/shaders/*.glsl"

        # libretro source files
        "${BOREALIS_DIR}/library/lib/extern/libretro-common/compat/*.c"
        "${BOREALIS_DIR}/library/lib/extern/libretro-common/encoding/*.c"
        "${BOREALIS_DIR}/library/lib/extern/libretro-common/features/*.c"

        # nxfmtwrapper source files
        "${BOREALIS_DIR}/library/lib/extern/nxfmtwrapper/*.cpp"

        # yoga source files
        "${BOREALIS_DIR}/library/lib/extern/yoga/src/yoga/event/*.cpp"
        "${BOREALIS_DIR}/library/lib/extern/yoga/src/yoga/*.cpp"

        # switch-libpulsar source files
        "${BOREALIS_DIR}/library/lib/extern/tinyxml2/*.cpp"

        # switch-libpulsar source files
        "${BOREALIS_DIR}/library/lib/extern/switch-libpulsar/src/*/*.c"

        # fmt source files -> COMPILED WITH WRAPPER
#        "${BOREALIS_DIR}/library/lib/extern/fmt/src/*.cc"

)

file(GLOB SOURCE_FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
)

add_executable(
        ${APP_NAME}.elf
        ${SOURCE_FILES}
        ${BOREALIS_SOURCE_FILES}
)

target_link_libraries(
        ${APP_NAME}.elf
        switch::libnx
        -L/opt/devkitpro/portlibs/switch/lib
        -L/opt/devkitpro/libnx/lib
        -lglfw3 -lEGL -lglapi -ldrm_nouveau -ldeko3d -lnx -lm #order of args mater
)

set_target_properties(
        ${APP_NAME}.elf PROPERTIES
        LINKER_LANGUAGE CXX # Replace this with C if you have C source files
        LINK_FLAGS "-specs=${LIBNX}/switch.specs -Wl,-no-as-needed -Wl,-Map,.map"
)

set(CMAKE_BUILD_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${APP_NAME}.elf.dir)
set(BUILD_ROMFS ${CMAKE_BUILD_DIRECTORY}/Resources)
cmake_info("Resources will be gathered in: ${BUILD_ROMFS}")

add_custom_command(
        TARGET ${APP_NAME}.elf
        PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "Gathering resources..."
        COMMAND ${CMAKE_COMMAND} -E remove_directory ${BUILD_ROMFS}
        COMMAND ${CMAKE_COMMAND} -E make_directory ${BUILD_ROMFS}
        COMMAND ${CMAKE_COMMAND} -E make_directory ${BUILD_ROMFS}/borealis
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${APP_ROMFS}/. ${BUILD_ROMFS}/.
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${BOREALIS_DIR}/resources/. ${BUILD_ROMFS}/borealis/.
        COMMAND ${CMAKE_COMMAND} -E echo "Resources have been gathered."
)


build_switch_binaries(
        ${APP_NAME}.elf
        ${APP_TITLE} ${APP_AUTHOR} ${APP_ICON} ${APP_VERSION} ${BUILD_ROMFS}
)

