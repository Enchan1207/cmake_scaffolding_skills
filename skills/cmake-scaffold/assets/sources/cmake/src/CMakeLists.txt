add_library(@LIBRARY_TARGET@)

target_sources(@LIBRARY_TARGET@ PRIVATE @LIBRARY_SOURCE@)

target_include_directories(@LIBRARY_TARGET@ PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
)
