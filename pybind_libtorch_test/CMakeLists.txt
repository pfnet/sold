cmake_minimum_required(VERSION 3.4)

find_package(Torch REQUIRED)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${TORCH_CXX_FLAGS}")

# I set PREFIX and SUFFIX here because I want to pass generated files to sold.
# The default SUFFIX depends on the system configuration and is difficult to
# infer.
pybind11_add_module(my_add_kernel numpy.cc)
set_target_properties(my_add_kernel PROPERTIES PREFIX "" SUFFIX ".so")
target_link_libraries(my_add_kernel PRIVATE "${TORCH_LIBRARIES}")

file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/soldout")
add_custom_target(
  my_add_kernel_soldout ALL
  COMMAND
    "${PROJECT_BINARY_DIR}/sold" -i "${CMAKE_CURRENT_BINARY_DIR}/my_add_kernel.so" -o
    "${CMAKE_CURRENT_BINARY_DIR}/soldout/my_add_kernel.so" --section-headers
    --check-output
  DEPENDS sold my_add_kernel)

# ${CMAKE_CURRENT_BINARY_DIR}/test_soldout_modules_original.py is for debug.
configure_file(
  test_soldout_modules.py
  ${CMAKE_CURRENT_BINARY_DIR}/test_soldout_modules_original.py @ONLY)
configure_file(
  test_soldout_modules.py
  ${CMAKE_CURRENT_BINARY_DIR}/soldout/test_soldout_modules.py @ONLY)

add_test(
  NAME pybind_libtorch_test
  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/soldout"
  COMMAND pytest -v)
