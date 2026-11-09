cmake_minimum_required(VERSION <cmake_version>)

project(
    <project_name>
    VERSION 0.1.0
    LANGUAGES <language>
)

add_subdirectory(src)

## プロジェクト構成としてCLIを含める場合は、以下をアンコメントする。この行は成果物に含めない。
# option(<project_name>_BUILD_CLI "Build CLI tool" ${PROJECT_IS_TOP_LEVEL})
# if(<project_name>_BUILD_CLI)
#     add_subdirectory(cli)
# endif()

## プロジェクト構成としてテストを含める場合は、以下をアンコメントする。この行は成果物に含めない。
# option(<project_name>_BUILD_TESTS "Build tests" OFF)
# if(<project_name>_BUILD_TESTS)
#     enable_language(CXX)
#     enable_testing()
#     add_subdirectory(tests)
# endif()
