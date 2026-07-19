if(NOT DEFINED RUNTIME_TARGET_FILE OR NOT EXISTS "${RUNTIME_TARGET_FILE}")
  message(FATAL_ERROR "Markei Windows runtime target was not built.")
endif()

if(NOT DEFINED RUNTIME_TARGET_DIR OR NOT IS_DIRECTORY "${RUNTIME_TARGET_DIR}")
  message(FATAL_ERROR "Markei Windows runtime target directory is unavailable.")
endif()

set(runtime_direct_deps "${RUNTIME_DIRECT_DEPS}")
set(runtime_direct_dirs "${RUNTIME_DIRECT_DIRS}")
string(REPLACE "|" ";" runtime_direct_deps "${runtime_direct_deps}")
string(REPLACE "|" ";" runtime_direct_dirs "${runtime_direct_dirs}")

if(DEFINED RUNTIME_FLUTTER_LIBRARY AND EXISTS "${RUNTIME_FLUTTER_LIBRARY}")
  list(APPEND runtime_direct_deps "${RUNTIME_FLUTTER_LIBRARY}")
endif()

file(TO_CMAKE_PATH "${RUNTIME_BINARY_DIR}" runtime_binary_dir)
set(runtime_search_dirs)
foreach(runtime_dir IN LISTS runtime_direct_dirs)
  file(TO_CMAKE_PATH "${runtime_dir}" runtime_dir_normalized)
  string(FIND "${runtime_dir_normalized}/" "${runtime_binary_dir}/"
    runtime_build_dir_prefix)
  if(NOT runtime_build_dir_prefix EQUAL 0)
    list(APPEND runtime_search_dirs "${runtime_dir}")
  endif()
endforeach()

foreach(runtime_dep IN LISTS runtime_direct_deps)
  if(NOT EXISTS "${runtime_dep}")
    message(FATAL_ERROR
      "Markei Windows runtime dependency is unresolved: ${runtime_dep}")
  endif()
  file(COPY "${runtime_dep}" DESTINATION "${RUNTIME_TARGET_DIR}")
endforeach()

foreach(runtime_dir IN LISTS runtime_search_dirs)
  file(GLOB runtime_dir_deps "${runtime_dir}/*.dll")
  foreach(runtime_dep IN LISTS runtime_dir_deps)
    file(COPY "${runtime_dep}" DESTINATION "${RUNTIME_TARGET_DIR}")
  endforeach()
endforeach()

file(GET_RUNTIME_DEPENDENCIES
  EXECUTABLES "${RUNTIME_TARGET_FILE}"
  DIRECTORIES "${RUNTIME_TARGET_DIR}"
  RESOLVED_DEPENDENCIES_VAR runtime_resolved_deps
  UNRESOLVED_DEPENDENCIES_VAR runtime_unresolved_deps
  PRE_EXCLUDE_REGEXES
    "api-ms-.*"
    "ext-ms-.*"
    "MSVCP.*"
    "ucrtbase.*"
    "VCRUNTIME.*"
  POST_EXCLUDE_REGEXES
    ".*[Ww][Ii][Nn][Dd][Oo][Ww][Ss][\\\\/][Ss]ystem32.*"
    ".*[Ww][Ii][Nn][Dd][Oo][Ww][Ss][\\\\/][Ss]ysWOW64.*")

if(runtime_unresolved_deps)
  list(FILTER runtime_unresolved_deps EXCLUDE REGEX
    "^(MSVCP|ucrtbase|VCRUNTIME).*")
endif()

if(runtime_unresolved_deps)
  list(JOIN runtime_unresolved_deps ", " runtime_unresolved_list)
  message(FATAL_ERROR
    "Unresolved Markei Windows runtime dependencies: ${runtime_unresolved_list}")
endif()

foreach(runtime_dep IN LISTS runtime_resolved_deps)
  file(COPY "${runtime_dep}" DESTINATION "${RUNTIME_TARGET_DIR}")
endforeach()
