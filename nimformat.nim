import nimpy, tables, pylib, re

#[
  Build with:
    nim c --threads:on --app:lib --out:nimformat.pyd --tlsEmulation:off nimformat.nim
]#

proc nim_sub*(s: string, dict: Table[string, string]): string {.exportpy.} =
  ## nim_sub(string, dict)
  ## 
  ## Receives a string in which all variables to be substituted are in the format 
  ## {variable}, as well as a dictionary in {'variable': 'value'} format.
  ## For each variable in the dictionary the function substitutes the value for the 
  ## variable name.
  ##
  ## Returns the supplied string with all substitutions applied.
  ##
  ## Example
  ## =======
  ## import nimformat
  ##
  ## strWithSubstitutions = '''
  ## This is a {variable1} which spans
  ## multiple lines and {variable2} multiple
  ## substitutions.
  ## '''
  ##
  ## variable1 = 'string'
  ## variable2 = 'contains'
  ##
  ## nimFormatEnv = dict(locals())
  ## nimFormatEnv = {str(key): str(nimFormatEnv[key]) for key in nimFormatEnv.keys() if '__' not in str(key)}
  ##
  ## strSubstituted = nimformat.nim_sub(strWithSubstitutions, nimFormatEnv)
  ## print(strSubstituted)
  ## 
  ## This is a string which spans
  ## multiple lines and contains multiple
  ## substitutions.
  var s = s
  for key, val in dict:
    s = (s.replace(re("({" & key & "})"), val))

  result = s


proc test_nim_sub*() {.exportpy.} =
  ## Tests the functionality of nim_sub()
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
