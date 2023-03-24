import numpy

import my_add_kernel

def test_mynumpy_add():
    # The size of arrays is pretty large because I had encountered a bug that
    # appears only for large arrays.
    a = numpy.random.rand(32)
    b = numpy.random.rand(32)
    r = my_add_kernel.add_arrays(a, b)
    assert numpy.allclose(a + b, r)
