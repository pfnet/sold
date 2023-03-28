#include <pybind11/numpy.h>
#include <pybind11/pybind11.h>

#include <ATen/ATen.h>
#include <ATen/Functions.h>
#include <ATen/Tensor.h>
#include <ATen/core/dispatch/Dispatcher.h>
#include <c10/core/DispatchKey.h>
#include <c10/util/ArrayRef.h>

namespace py = pybind11;

py::array_t<double> add_arrays(py::array_t<double> input1, py::array_t<double> input2) {
    py::buffer_info buf1 = input1.request(), buf2 = input2.request();

    if (buf1.ndim != 1 || buf2.ndim != 1) throw std::runtime_error("Number of dimensions must be one");

    if (buf1.size != buf2.size) throw std::runtime_error("Input shapes must match");

    /* No pointer is passed, so NumPy will allocate the buffer */
    auto result = py::array_t<double>(buf1.size);

    py::buffer_info buf3 = result.request();

    double* ptr1 = static_cast<double*>(buf1.ptr);
    double* ptr2 = static_cast<double*>(buf2.ptr);
    double* ptr3 = static_cast<double*>(buf3.ptr);

    at::Tensor tensor1 = at::from_blob(ptr1, buf1.size, at::kDouble).clone();
    at::Tensor tensor2 = at::from_blob(ptr2, buf1.size, at::kDouble).clone();
    at::Tensor tensor3 = tensor1 + tensor2;

    for (size_t idx = 0; idx < buf1.shape[0]; idx++) ptr3[idx] = tensor3[idx].item<double>();

    return result;
}

PYBIND11_MODULE(my_add_kernel, m) {
    m.def("add_arrays", &add_arrays, "Add two NumPy arrays using libtorch");
}
