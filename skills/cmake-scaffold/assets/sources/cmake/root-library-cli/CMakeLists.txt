cmake_minimum_required(VERSION 3.21)

project(@PROJECT_NAME@ VERSION 0.1.0 LANGUAGES C)

add_subdirectory(src)

option(@PROJECT_NAME@_BUILD_CLI "Build the CLI" ${PROJECT_IS_TOP_LEVEL})
if(@PROJECT_NAME@_BUILD_CLI)
    add_subdirectory(cli)
endif()
