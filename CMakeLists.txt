cmake_minimum_required (VERSION 3.5 FATAL_ERROR)

# ------------------
# Configure CMake project
# ------------------
project(SimpleSwitchBrowser)
set (SimpleSwitchBrowser_VERSION_MAJOR 0)
set (SimpleSwitchBrowser_VERSION_MINOR 0)
set (SimpleSwitchBrowser_VERSION_REVISION 1)
set (SimpleSwitchBrowser_VERSION_TAG f) # f means forward -> include commits after a given release
set (SimpleSwitchBrowser_VERSION_STRING "${gundam_VERSION_MAJOR}.${gundam_VERSION_MINOR}.${gundam_VERSION_REVISION}${gundam_VERSION_TAG}")
set (APP_VERSION ${SimpleSwitchBrowser_VERSION_STRING})
configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/cmake/VersionConfig.h.in ${CMAKE_BINARY_DIR}/generated/VersionConfig.h )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(options)
include(utils)

cmake_info("Building ${APP_TITLE} version ${SimpleSwitchBrowser_VERSION_STRING}.")

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
endif ()

# ------------------
# Borealis Lib
# ------------------
set(BOREALIS_DIR ${SUBMODULES_DIR}/borealis)
add_compile_definitions(BOREALIS_RESOURCES=\"romfs:/borealis/\")
cmake_info("BOREALIS_DIR is ${BOREALIS_DIR}")
set(BOREALIS_INC_DIR ${BOREALIS_DIR}/library/include)




# ------------------
# Libraries
# ------------------
include(nx-utils)


# ------------------
# Includes
# ------------------
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/include")
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/cpp-generic-toolbox/include")
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/simple-cpp-logger/include")
include_directories( ${CMAKE_BINARY_DIR}/generated/ )

include_directories("${PORTLIBS}/include")
include_directories("${LIBNX}/include")

include_directories("${BOREALIS_INC_DIR}")


# Meta information about the app
set(APP_NAME SimpleSwitchBrowser)
set(APP_TITLE ${APP_NAME})
set(APP_AUTHOR "Nadrino")
set(APP_ICON "${CMAKE_CURRENT_SOURCE_DIR}/assets/icon_gui.jpg")
set(APP_ROMFS "${CMAKE_CURRENT_SOURCE_DIR}/romfs")

file(GLOB SOURCE_FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
)

add_executable(
        ${APP_NAME}.elf
        ${SOURCE_FILES}
)

target_link_libraries(
        ${APP_NAME}.elf
        switch::libnx
        -L/opt/devkitpro/portlibs/switch/lib
        -L/opt/devkitpro/libnx/lib
        -lglfw3 -lEGL -lglapi -ldrm_nouveau -lm -lnx
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

