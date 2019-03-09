#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from setuptools import Extension
from setuptools import setup


sources = """nimformat.c
nimpy_nimpy.c
nimpy_py_lib.c
nimpy_py_types.c
nimpy_py_utils.c
pylib_class.c
pylib_ops.c
pylib_print.c
pylib_pylib.c
pylib_pyrandom.c
pylib_pystring.c
pylib_strops.c
pylib_tonim.c
pylib_types.c
stdlib_algorithm.c
stdlib_assertions.c
stdlib_bitops.c
stdlib_complex.c
stdlib_dynlib.c
stdlib_hashes.c
stdlib_io.c
stdlib_iterators.c
stdlib_json.c
stdlib_lexbase.c
stdlib_locks.c
stdlib_macros.c
stdlib_math.c
stdlib_options.c
stdlib_os.c
stdlib_ospaths.c
stdlib_osseps.c
stdlib_parsejson.c
stdlib_parseutils.c
stdlib_pathnorm.c
stdlib_pcre.c
stdlib_posix.c
stdlib_random.c
stdlib_re.c
stdlib_rtarrays.c
stdlib_sequtils.c
stdlib_sharedlist.c
stdlib_streams.c
stdlib_strformat.c
stdlib_strscans.c
stdlib_strutils.c
stdlib_system.c
stdlib_tables.c
stdlib_times.c
stdlib_typetraits.c
stdlib_unicode.c
stdlib_widestrs.c""".splitlines()


setup(
    ext_modules = [
        Extension(
            name               = "nimformat",
            sources            = sources,
            extra_compile_args = ["-flto", "-ffast-math", "-march=native", "-O3"],
            extra_link_args    = ["-flto", "-ffast-math", "-march=native", "-O3"],
            include_dirs       = ["."],
        )
    ]
)
