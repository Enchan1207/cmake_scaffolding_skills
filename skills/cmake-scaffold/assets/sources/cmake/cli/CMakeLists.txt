add_executable(<project_name>_cli)

target_sources(<project_name>_cli PRIVATE
    main.c
)

target_link_libraries(<project_name>_cli PRIVATE 
    <project_name>_library
)
