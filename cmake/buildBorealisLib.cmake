# Borealis lib builder

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
)

add_library(Borealis STATIC ${BOREALIS_SOURCE_FILES})

set(BOREALIS_DIR ${SUBMODULES_DIR}/borealis)
cmake_info("BOREALIS_DIR is ${BOREALIS_DIR}")
set(BOREALIS_INC_DIR ${BOREALIS_DIR}/library/include)


target_compile_definitions(
        Borealis PRIVATE
        YG_ENABLE_EVENTS
)

target_include_directories(
        Borealis PUBLIC
        ${BOREALIS_INC_DIR}
        ${BOREALIS_DIR}/library/lib/extern/fmt/include
        ${BOREALIS_DIR}/library/lib/extern/yoga/src
        ${BOREALIS_DIR}/library/lib/extern/nanovg-deko3d/include
        ${BOREALIS_DIR}/library/lib/extern/tweeny/include
        ${BOREALIS_INC_DIR}/borealis/extern
        ${BOREALIS_INC_DIR}/borealis/extern/tinyxml2
        ${BOREALIS_DIR}/library/lib/extern/switch-libpulsar/include
)

#target_link_libraries(
#        Borealis
#        -ldeko3d -lnx -lm
#)

install(TARGETS Borealis DESTINATION lib)
