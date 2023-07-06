find_package(Torch REQUIRED)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${TORCH_CXX_FLAGS}")

if(NOT SOLD_CPU_ONLY_LIBTORCH)
  add_subdirectory(cuBLASLt_test)
  add_subdirectory(cuBLAS_test)
endif()

add_library(torch_test SHARED torch_test.cc)
target_link_libraries(torch_test PRIVATE "${TORCH_LIBRARIES}"
                                         -Wl,-soname,libtorch_test.so)
set_target_properties(torch_test PROPERTIES SUFFIX ".so.original")

# Make share objects
add_custom_target(
  torch_test_soldout ALL
  COMMAND
    GLOG_log_dir=${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_BINARY_DIR}/sold -i
    ${CMAKE_CURRENT_BINARY_DIR}/libtorch_test.so.original -o
    ${CMAKE_CURRENT_BINARY_DIR}/libtorch_test.so.soldout --section-headers
    --check-output
  DEPENDS torch_test sold
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

add_custom_target(
  torch_test_soldout_wo_section
  EXCLUDE_FROM_ALL
  COMMAND
    GLOG_log_dir=${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_BINARY_DIR}/sold -i
    ${CMAKE_CURRENT_BINARY_DIR}/libtorch_test.so.original -o
    ${CMAKE_CURRENT_BINARY_DIR}/libtorch_test.so.wosection.soldout
    --check-output libtorch_test.so
  DEPENDS torch_test sold
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

add_custom_target(
  libtorch_test_so_symlink ALL
  COMMAND ln -sf libtorch_test.so.soldout libtorch_test.so
  DEPENDS torch_test_soldout
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

# Make test binaries
add_custom_target(
  torch_test_main ALL
  COMMAND
    g++ ${CMAKE_CURRENT_SOURCE_DIR}/torch_test_main.cc
    ${CMAKE_CURRENT_BINARY_DIR}/libtorch_test.so.original -o torch_test_main
  DEPENDS torch_test libtorch_test_so_symlink
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

add_custom_target(
  torch_test_main_linked_soldout
  EXCLUDE_FROM_ALL
  COMMAND
    g++ ${CMAKE_CURRENT_SOURCE_DIR}/torch_test_main.cc
    ${CMAKE_CURRENT_BINARY_DIR}/libtorch_test.so.soldout -o
    torch_test_main_linked_sold
  DEPENDS torch_test_soldout libtorch_test_so_symlink
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

add_executable(torch_test_main_dlopen torch_test_main_dlopen.cc)
target_link_libraries(torch_test_main_dlopen PRIVATE -ldl)

# Add tests
add_test(
  NAME libtorch_test
  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
  COMMAND ./torch_test_main)
set_tests_properties(
  libtorch_test PROPERTIES ENVIRONMENT
                           "LD_LIBRARY_PATH=${CMAKE_CURRENT_BINARY_DIR}")
add_test(
  NAME libtorch_test_dlopen
  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
  COMMAND ./torch_test_main_dlopen)
set_tests_properties(
  libtorch_test_dlopen PROPERTIES ENVIRONMENT
                                  "LD_LIBRARY_PATH=${CMAKE_CURRENT_BINARY_DIR}")
