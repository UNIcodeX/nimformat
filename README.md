# nimformat

The nimformat library is the result of an experiment in using the excellent nimpy module, for the awesome Nim programming language, to create a test library, for Python. The goal was to learn some about Nim, nimpy, creating native Python modules, and to see what, if any, speed boosts could be realized.

Currently, there are negligible, if any differences in speed between Python and Nim native library when passing in a new dict of values. Experiments may continue.

The `nim_sub()` function is a rudimentary implementation of string substitution in a similar way to how Python accepts a dictionary for its `string.format()`.


# Install
- `pip install nimformat`


# Build it yourself
The Nim native Python library can be built by issuing the following command.

Debug:
`nim c --app:lib --out:nimformat.pyd nimformat.nim`

Production:
`nim c --app:lib --out:nimformat.pyd -d:release nimformat.nim`

**NOTE:** This was done using the latest development version of Nim, which is 0.19.9 at the time of this writing.


# Benchmarks
Simple benchmarks with Python's `timeit` module yield the following results. Tests were done with the following options for `timeit`:
```python
timeit.repeat(
  setup=SETUP_CODE,
  stmt=TEST_CODE,
  repeat=3,
  number=20
  )
```
Times
-----
|Test                                   | Time to Complete |
|---------------------------------------|------------------|
|Pure Python time                       | .000202s         |
|Pure Python [no locals()] time         | .000286s         |
|Nim dylib [no locals()] time           | .000547s         |
|Nim dylib sub_multi [no locals()] time | .000220s         |

See `test_nimformat.py` for more details.


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

# Platforms

- ✅ Linux
- ✅ Windows
- ✅ Mac
- ✅ Android
- ✅ Raspberry Pi
- ✅ BSD
