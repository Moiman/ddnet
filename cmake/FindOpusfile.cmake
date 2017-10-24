find_package(PkgConfig QUIET)
pkg_check_modules(PC_OPUSFILE opusfile)

set_extra_dirs_lib(OPUSFILE opus)
find_library(OPUSFILE_LIBRARY
  NAMES opusfile
  HINTS ${HINTS_OPUSFILE_LIBDIR} ${PC_OPUSFILE_LIBDIR} ${PC_OPUSFILE_LIBRARY_DIRS}
  PATHS ${PATHS_OPUSFILE_LIBDIR}
)
set_extra_dirs_include(OPUSFILE opus "${OPUSFILE_LIBRARY}")
find_path(OPUSFILE_INCLUDEDIR opusfile.h
  PATH_SUFFIXES opus
  HINTS ${HINTS_OPUSFILE_INCLUDEDIR} ${PC_OPUSFILE_INCLUDEDIR} ${PC_OPUSFILE_INCLUDE_DIRS}
  PATHS ${PATHS_OPUSFILE_INCLUDEDIR}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Opusfile DEFAULT_MSG OPUSFILE_LIBRARY OPUSFILE_INCLUDEDIR)

mark_as_advanced(OPUSFILE_LIBRARY OPUSFILE_INCLUDEDIR)

set(OPUSFILE_LIBRARIES ${OPUSFILE_LIBRARY})
set(OPUSFILE_INCLUDE_DIRS ${OPUSFILE_INCLUDEDIR})

string(FIND "${OPUSFILE_LIBRARY}" "${PROJECT_SOURCE_DIR}" LOCAL_PATH_POS)
if(LOCAL_PATH_POS EQUAL 0 AND TARGET_OS STREQUAL "windows")
  set(OPUSFILE_COPY_FILES
    "${EXTRA_OPUSFILE_LIBDIR}/libogg.dll"
    "${EXTRA_OPUSFILE_LIBDIR}/libopus.dll"
    "${EXTRA_OPUSFILE_LIBDIR}/libopusfile.dll"
    "${EXTRA_OPUSFILE_LIBDIR}/libwinpthread-1.dll"
  )
  if (TARGET_BITS EQUAL 32)
    list(APPEND OPUSFILE_COPY_FILES
      "${EXTRA_OPUSFILE_LIBDIR}/libgcc_s_sjlj-1.dll"
    )
  endif()
else()
  set(OPUSFILE_COPY_FILES)
endif()
