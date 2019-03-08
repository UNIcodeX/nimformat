import nimpy, tables, pylib, re


proc nim_sub*(s: string, dict: Table[string, string]): string {.exportpy.} =
  var s = s
  for key, val in dict:
    s = (s.replace(re("({" & key & "})"), val))

  result = s


proc test_nim_sub*() {.exportpy.} =
  var
    # table_sub = initTable[string, string]()
    table_sub = {"": ""}.toTable
    strTest: string
  table_sub["variable1"] = "string"
  table_sub["variable2"] = "contains"

  # echo(type(table_sub))
  # echo(table_sub)

  strTest = """
  This is a {variable1} which spans
  multiple lines and {variable2} multiple
  substitutions.
  """  

  let result = nim_sub(strTest, table_sub)
  echo(result)


proc print_usage() {.exportpy.} =
  echo("""
  import nimformat

  strWithSubstitutions = '''
  This is a {variable1} which spans
  multiple lines and {variable2} multiple
  substitutions.
  '''

  variable1 = 'string'
  variable2 = 'contains'

  nimFormatEnv = dict(locals())
  nimFormatEnv = {str(key): str(nimFormatEnv[key]) for key in nimFormatEnv.keys() if '__' not in str(key)}

  strSubstituted = nimformat.nim_sub(strWithSubstitutions, nimFormatEnv)
  print(strSubstituted)
  """)

  test_nim_sub()