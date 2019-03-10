# nimformat

The nimformat library is the result of an experiment in using the excellent nimpy module, for the awesome Nim programming language, to create a test library, for Python. The goal was to learn some about Nim, nimpy, creating native Python modules, and to see what, if any, speed boosts could be realized.

The `nim_sub()` function is a rudimentary implementation of string substitution in a similar way to how Python accepts a dictionary for its `string.format()`.

The Nim native Python library can be built by issuing the following command.

`nim c --threads:on --app:lib --out:nimformat.pyd --tlsEmulation:off nimformat.nim`

NOTE: This was done using the latest development version of Nim, which is 0.19.9 at the time of this writing.

Simple benchmarks with Python's `timeit` module yield the following results. See `test_nimformat.py` for more details.
```
Pure Python time                       : 1.71267s
Pure Python [no locals()] time         : 1.89296s
Nim dylib time                         : 0.28290s
Nim dylib [no locals()] time           : 0.00165s
Nim dylib sub_multi time               : 0.29930s
Nim dylib sub_multi [no locals()] time : 0.00078s
```

# Use

Example 1:
```python
import nimformat

variable1 = 'string'
variable2 = 'contains'

dictSub = dict(locals())
dictSub = {str(key): str(dictSub[key]) for key in dictSub.keys() if '__' not in str(key)}

strWithSubstitutions = """
This is a {variable1} which spans
multiple lines and {variable2} multiple
substitutions.
"""

strSubstituted = nimformat.nim_sub(strWithSubstitutions, dictSub)
```

Example 2:
```python
import nimformat

dictSub = {
  'variable1': 'string',
  'variable2': 'contains'
}

strWithSubstitutions = """
This is a {variable1} which spans
multiple lines and {variable2} multiple
substitutions.
"""

strSubstituted = nimformat.nim_sub(strWithSubstitutions, dictSub)
```

# Install

- `pip install nimformat`

# Platforms

- ✅ Linux
- ✅ Windows
- ✅ Mac
- ✅ Android
- ✅ Raspberry Pi
- ✅ BSD
