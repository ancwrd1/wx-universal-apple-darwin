#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "wx::wxregex" for configuration "Release"
set_property(TARGET wx::wxregex APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wx::wxregex PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libwxregexu-3.2.a"
  )

list(APPEND _cmake_import_check_targets wx::wxregex )
list(APPEND _cmake_import_check_files_for_wx::wxregex "${_IMPORT_PREFIX}/lib/libwxregexu-3.2.a" )

# Import target "wx::wxjpeg" for configuration "Release"
set_property(TARGET wx::wxjpeg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wx::wxjpeg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libwxjpeg-3.2.a"
  )

list(APPEND _cmake_import_check_targets wx::wxjpeg )
list(APPEND _cmake_import_check_files_for_wx::wxjpeg "${_IMPORT_PREFIX}/lib/libwxjpeg-3.2.a" )

# Import target "wx::wxpng" for configuration "Release"
set_property(TARGET wx::wxpng APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wx::wxpng PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libwxpng-3.2.a"
  )

list(APPEND _cmake_import_check_targets wx::wxpng )
list(APPEND _cmake_import_check_files_for_wx::wxpng "${_IMPORT_PREFIX}/lib/libwxpng-3.2.a" )

# Import target "wx::wxtiff" for configuration "Release"
set_property(TARGET wx::wxtiff APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wx::wxtiff PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libwxtiff-3.2.a"
  )

list(APPEND _cmake_import_check_targets wx::wxtiff )
list(APPEND _cmake_import_check_files_for_wx::wxtiff "${_IMPORT_PREFIX}/lib/libwxtiff-3.2.a" )

# Import target "wx::wxmono" for configuration "Release"
set_property(TARGET wx::wxmono APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wx::wxmono PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C;CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libwx_osx_cocoau-3.2-Darwin.a"
  )

list(APPEND _cmake_import_check_targets wx::wxmono )
list(APPEND _cmake_import_check_files_for_wx::wxmono "${_IMPORT_PREFIX}/lib/libwx_osx_cocoau-3.2-Darwin.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
