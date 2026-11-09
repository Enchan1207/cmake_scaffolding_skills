include(FetchContent)
FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG v1.15.2
)
FetchContent_MakeAvailable(googletest)

add_executable(<project_name>_test test_factorial.cpp)
target_link_libraries(<project_name>_test PRIVATE
    GTest::gtest_main
    <project_name>_library
)

include(GoogleTest)
gtest_discover_tests(<project_name>_test)
