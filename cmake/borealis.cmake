

add_compile_definitions(BOREALIS_RESOURCES=\"romfs:/borealis/\")
set(BOREALIS_DIR ${SUBMODULES_DIR}/borealis)
set(BOREALIS_INC_DIR ${BOREALIS_DIR}/library/include)

file( GLOB BOREALIS_SRC_FILES
        "${BOREALIS_DIR}/library/lib/*.cpp"
        "${BOREALIS_DIR}/library/lib/extern/*/*.c"
        "${BOREALIS_DIR}/library/lib/extern/*/*/*.c"
        "${BOREALIS_DIR}/library/lib/*.cpp"
        "${BOREALIS_DIR}/library/lib/*.c"
        "${BOREALIS_DIR}/library/lib/extern/glad/*.c"
        "${BOREALIS_DIR}/library/lib/extern/nanovg/*.c"
        "${BOREALIS_DIR}/library/lib/extern/libretro-common/compat/*.c"
        "${BOREALIS_DIR}/library/lib/extern/libretro-common/encodings/*.c"
        "${BOREALIS_DIR}/library/lib/extern/libretro-common/features/*.c"
        "${BOREALIS_DIR}/library/lib/extern/fmt/src/*.cc"
        )

include_directories(
        ${BOREALIS_DIR}/library/lib/extern/fmt/include
        ${BOREALIS_INC_DIR}
        ${BOREALIS_INC_DIR}/borealis
        ${BOREALIS_INC_DIR}/borealis/extern
        ${BOREALIS_INC_DIR}/borealis/extern/glad
        ${BOREALIS_INC_DIR}/borealis/extern/nanovg
        ${BOREALIS_INC_DIR}/borealis/extern/libretro-common
#        ${PROJECT_SOURCE_DIR}/shortcuts
#        ${PROJECT_SOURCE_DIR}/shortcuts/libretro-common
        )


