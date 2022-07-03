

set( APP_SRC_DIR ${PROJECT_SOURCE_DIR}/src )

set( APP_NAME "SimpleSwitchBrowser" )
set( APP_TITLE ${APP_NAME})
set( APP_AUTHOR "Nadrino")
set( APP_ICON "${CMAKE_CURRENT_SOURCE_DIR}/assets/icon_gui.jpg")
set( APP_ROMFS "${CMAKE_CURRENT_SOURCE_DIR}/resources")

set( APP_SRC_FILES
        ${APP_SRC_DIR}/${APP_NAME}.cpp
        ${APP_SRC_DIR}/AppFrontEnd/src/BrowserApp.cpp
        ${APP_SRC_DIR}/Frames/src/BrowserFrame.cpp
        )

add_executable( ${APP_NAME}.elf
        ${APP_SRC_FILES}
        ${BOREALIS_SRC_FILES}
        )

target_include_directories( ${APP_NAME}.elf PUBLIC
        ${APP_SRC_DIR}/AppFrontEnd/include
        ${APP_SRC_DIR}/Frames/include
        ${BOREALIS_DIR}/library/include
        )

message("BOREALIS_DIR = ${BOREALIS_DIR}")

target_link_libraries(
        ${APP_NAME}.elf PUBLIC
        switch::libnx
        -L/opt/devkitpro/portlibs/switch/lib
        -L/opt/devkitpro/libnx/lib
        ${ZLIB_LIBRARIES}
        ${FREETYPE_LIBRARIES}
        -lglfw3 -lEGL -lglapi -ldrm_nouveau -lm -lnx
        #        -lSDL2 -march=armv8-a -fPIE -lEGL -lglapi -ldrm_nouveau -lnx
        #        -lnx -lfreetype -lSDL2_ttf -lSDL2_gfx -lSDL2_image -lSDL2 -lEGL -lGLESv2 -lglapi -ldrm_nouveau -lpng -ljpeg -L/opt/devkitpro/portlibs/switch/lib -lSDL2 -march=armv8-a -fPIE -L/opt/devkitpro/libnx/lib -lEGL -lglapi -ldrm_nouveau -lnx -L/opt/devkitpro/portlibs/switch/lib -lfreetype -lbz2 -lpng16 -lz -lm -lnx -lz -lwebp
        #        -lSDL2  -march=armv8-a -fPIE -lEGL -lglapi -ldrm_nouveau -lSDL2_ttf -lfreetype
        #        -lpng -ljpeg -lnx
        #        -lfreetype -lSDL2_mixer -lopusfile -lopus -lmodplug -lmpg123 -lvorbisidec -logg -lSDL2_ttf -lSDL2_gfx -lSDL2_image -lSDL2 -lEGL -lGLESv2 -lglapi -ldrm_nouveau -lwebp -lpng -ljpeg
)

set_target_properties(${APP_NAME}.elf PROPERTIES
        LINKER_LANGUAGE CXX # Replace this with C if you have C source files
        LINK_FLAGS "-specs=${LIBNX}/switch.specs -Wl,-no-as-needed -Wl,-Map,.map")


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
        ${APP_NAME} ${APP_AUTHOR} ${APP_ICON} ${APP_VERSION} ${BUILD_ROMFS}
)