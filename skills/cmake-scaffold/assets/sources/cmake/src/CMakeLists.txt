add_library(<project_name>_library)

target_sources(<project_name>_library PRIVATE
    func.c
)

target_include_directories(<project_name>_library PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
)
