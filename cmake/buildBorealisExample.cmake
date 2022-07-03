# Borealis lib builder

file(GLOB BRLS_DEMO_SOURCE_FILES
        "${BOREALIS_DIR}/demo/*.cpp"
)

add_executable(
        BrlsDemo.elf
        ${BRLS_DEMO_SOURCE_FILES}
        ${BOREALIS_SOURCE_FILES}
)

target_compile_definitions(
        BrlsDemo.elf PRIVATE
        YG_ENABLE_EVENTS
)

target_include_directories(
        BrlsDemo.elf PUBLIC
        ${BOREALIS_DIR}/demo
        ${BOREALIS_INC_DIR}
        ${BOREALIS_DIR}/library/lib/extern/fmt/include
        ${BOREALIS_DIR}/library/lib/extern/yoga/src
        ${BOREALIS_DIR}/library/lib/extern/nanovg-deko3d/include
        ${BOREALIS_DIR}/library/lib/extern/tweeny/include
        ${BOREALIS_INC_DIR}/borealis/extern
        ${BOREALIS_INC_DIR}/borealis/extern/tinyxml2
        ${BOREALIS_DIR}/library/lib/extern/switch-libpulsar/include
)

target_link_libraries(
        BrlsDemo.elf
#        Borealis
        switch::libnx
        -L/opt/devkitpro/portlibs/switch/lib
        -L/opt/devkitpro/libnx/lib
        -lglfw3 -lEGL -lglapi -ldrm_nouveau -ldeko3d -lnx -lm #order of args mater
)

set_target_properties(
        BrlsDemo.elf PROPERTIES
        LINKER_LANGUAGE CXX # Replace this with C if you have C source files
        LINK_FLAGS "-specs=${LIBNX}/switch.specs -Wl,-no-as-needed -Wl,-Map,.map"
)


set(DEMO_BUILD_ROMFS ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/BrlsDemo.elf.dir/Resources)
cmake_info("Resources will be gathered in: ${DEMO_BUILD_ROMFS}")


add_custom_command(
        TARGET BrlsDemo.elf
        PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "Gathering resources..."
        COMMAND ${CMAKE_COMMAND} -E remove_directory ${DEMO_BUILD_ROMFS}
        COMMAND ${CMAKE_COMMAND} -E make_directory ${DEMO_BUILD_ROMFS}
#        COMMAND ${CMAKE_COMMAND} -E make_directory ${DEMO_BUILD_ROMFS}/borealis
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${BOREALIS_DIR}/resources/. ${DEMO_BUILD_ROMFS}/.
        COMMAND ${CMAKE_COMMAND} -E echo "Resources have been copied for BrlsDemo."
)


build_switch_binaries(
        BrlsDemo.elf
        BrlsDemo ${APP_AUTHOR} ${APP_ICON} ${APP_VERSION} ${BOREALIS_DIR}/resources
)
