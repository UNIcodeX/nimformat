# importing the required modules
import timeit

def pure_python_time():
  SETUP_CODE = '''
  '''

  TEST_CODE = '''
variable1 = 'string'
variable2 = 'contains'

strWithSubstitutions = """
This is a {variable1} which spans
multiple lines and {variable2} multiple
substitutions.""".format(**locals())
'''
  # timeit.repeat statement
  times = timeit.repeat(
    setup=SETUP_CODE,
    stmt=TEST_CODE,
    repeat=3,
    number=20
    )

  # printing minimum exec. time
  print('Pure Python time                       : {}'.format(min(times)))


def pure_python_no_locals_time():
  SETUP_CODE = '''
  '''

  TEST_CODE = '''
dictSub = {
  'variable1': 'string',
  'variable2': 'contains'
}

strWithSubstitutions = """
This is a {variable1} which spans
multiple lines and {variable2} multiple
substitutions.""".format(**dictSub)
'''
  # timeit.repeat statement
  times = timeit.repeat(
    setup=SETUP_CODE,
    stmt=TEST_CODE,
    repeat=3,
    number=20
    )

  # printing minimum exec. time
  print('Pure Python [no locals()] time         : {}'.format(min(times)))


def nim_copy_locals_time():
  SETUP_CODE = '''
import nimformat
'''

  TEST_CODE = '''
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
'''

  # timeit.repeat statement
  times = timeit.repeat(
    setup=SETUP_CODE,
    stmt=TEST_CODE,
    repeat=3,
    number=20
    )

  # printing minimum exec. time
  print('Nim dylib time                         : {}'.format(min(times)))


def nim_no_locals_time():
  SETUP_CODE = '''
import nimformat
'''

  TEST_CODE = '''
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
'''

  # timeit.repeat statement
  times = timeit.repeat(
    setup=SETUP_CODE,
    stmt=TEST_CODE,
    repeat=3,
    number=20
    )

  # printing minimum exec. time
  print('Nim dylib [no locals()] time           : {}'.format(min(times)))

def nim_copy_locals_multi_time():
  SETUP_CODE = '''
import nimformat
'''

  TEST_CODE = '''
variable1 = 'string'
variable2 = 'contains'

dictSub = dict(locals())
dictSub = {str(key): str(dictSub[key]) for key in dictSub.keys() if '__' not in str(key)}

strWithSubstitutions = """
This is a {variable1} which spans
multiple lines and {variable2} multiple
substitutions.
"""

strSubstituted = nimformat.nim_sub_multi(strWithSubstitutions, dictSub)
'''

  # timeit.repeat statement
  times = timeit.repeat(
    setup=SETUP_CODE,
    stmt=TEST_CODE,
    repeat=3,
    number=20
    )

  # printing minimum exec. time
  print('Nim dylib sub_multi time               : {}'.format(min(times)))


def nim_no_locals_multi_time():
  SETUP_CODE = '''
import nimformat
'''

  TEST_CODE = '''
dictSub = {
  'variable1': 'string',
  'variable2': 'contains'
}

strWithSubstitutions = """
This is a {variable1} which spans
multiple lines and {variable2} multiple
substitutions.
"""

strSubstituted = nimformat.nim_sub_multi(strWithSubstitutions, dictSub)
'''

  # timeit.repeat statement
  times = timeit.repeat(
    setup=SETUP_CODE,
    stmt=TEST_CODE,
    repeat=3,
    number=20
    )

  # printing minimum exec. time
  print('Nim dylib sub_multi [no locals()] time : {}'.format(min(times)))


if __name__ == "__main__":
  pure_python_time()
  pure_python_no_locals_time()
  nim_copy_locals_time()
  nim_no_locals_time()
  nim_copy_locals_multi_time()
  nim_no_locals_multi_time()
