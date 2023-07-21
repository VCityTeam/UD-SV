# How to wrap C++ code in a Python application

## Introduction
We wrap C++ code to gain some computation speed in a interpreted language. In the choices of wrapping libraries, we based our choices with this [article](http://scipy-lectures.org/advanced/interfacing_with_c/interfacing_with_c.html).
It resumes the different method to wrap C++ in Python.

We prefer using [SWIG](https://en.wikipedia.org/wiki/SWIG) rather than [Cython](https://en.wikipedia.org/wiki/Cython) because :
- it has more compatibility (e.g. custom [SWIG macros in CMake](https://cmake.org/cmake/help/latest/module/UseSWIG.html)).
- it's more flexible with [a support of a variety of high-level programming languages](https://www.swig.org/compare.html).
- it's easy to use, because it's generated all wrapping files based on a simple interface file.

## SWIG Links
- [Install SWIG](../Install/InstallSwig.md)
- [SWIG repository](https://github.com/swig/swig/tree/master)
- [Full documentation on SWIG's support of Python](https://www.swig.org/Doc4.1/SWIGDocumentation.html#Python)
- [List of examples showing several use cases](https://github.com/swig/swig/tree/master/Examples/python)
- [Step-by-step wrapping tutorial](https://dridk.me/swig.html)
- [SWIG and CMake example](https://iamsorush.com/posts/cpp-csharp-swig/)

## Cython Links
- [Hello World](https://cython.readthedocs.io/en/latest/src/tutorial/cython_tutorial.html)
- [Use C++ in Cython](https://cython.readthedocs.io/en/latest/src/userguide/wrapping_CPlusPlus.html)
- [Use CMake with Cython](https://github.com/kmhsonnenkind/cmake-cython-example)
- [Solving the C++/Python bindings challenge with Cython](https://dmtn-013.lsst.io/#solving-the-c-python-bindings-challenge-with-cython)
