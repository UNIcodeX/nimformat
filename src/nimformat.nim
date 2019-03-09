import nimpy, tables, pylib, re, strutils

#[
  Build Debug:
    nim c --app:lib --out:nimformat.[pyd|so] nimformat.nim

  Build Release:
  nim c --app:lib --out:nimformat.[pyd|so] -d:release nimformat.nim
]#

# TODO: Add exception handling in case the passed in type(s) are not what is reqired by the procs.
# TODO: Possibly related to above... Check type of passed in parameters and raise an error gracefully.

proc nim_sub*(s: string, dict: Table[string, string]): string {.exportpy.} =
  ## nim_sub(string, dict)
  ## 
  ## Receives a string in which all variables to be substituted are in the format 
  ## {variable}, as well as a dictionary in {'variable': 'value'} format. For each
  ## variable in the dictionary the function substitutes the value for the 
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
  ## '''
  ##
  ## variable1 = 'string'
  ## variable2 = 'contains'
  ##
  ## dSubs = dict(locals())
  ## dSubs = {str(k): str(dSubs[k]) for k in dSubs.keys() if '__' not in str(k)}
  ##
  ## strSubstituted = nimformat.nim_sub(strWithSubstitutions, dSubs)
  ## print(strSubstituted)
  ## 
  ## This is a string which spans
  ## multiple lines and contains multiple
  ## substitutions.
  var s = s
  for key, val in dict:
    s = (s.replace(re("({" & key & "})"), val))

  result = s


proc nim_sub_multi*(s: string, dict: Table[string, string]): string {.exportpy.} =
  ## nim_sub_multi(string, dict)
  ##
  ## Does the same thing as nim_sub(), but much more efficiently for substitution
  ## operations involving more than one variable.
  var
    s = s
    d = @[("", "")]
  
  for pair in dict.pairs:
    d.add(("{"&pair[0]&"}", pair[1]))

  result = s.multiReplace(d)


when not defined(release):
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


  proc test_nim_sub_multi*() {.exportpy.} =
    ## Tests the functionality of nim_sub()
    var
      # table_sub = initTable[string, string]()
      table_sub = {"": ""}.toTable
      strTest: string
    table_sub["variable1"] = "string"
    table_sub["variable2"] = "contains"

    strTest = """
    This is a {variable1} which spans
    multiple lines and {variable2} multiple
    substitutions.
    """  

    let result = nim_sub_multi(strTest, table_sub)
    echo(result)
