from distutils.core import setup
from Cython.Build import cythonize

setup(name='Cython Example',
      ext_modules=cythonize(["*.pyx"]))