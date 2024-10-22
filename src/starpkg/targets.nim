import starintel_doc
import std/json


proc target*(dataset, target, actor: string, bulk, recurring: bool = false,
             input: string = "", options: string = "", delay: int = 0) =
  var
    outputFile: File
    inscopeFile: File
    outscopeFile: File
    option: JsonNode
    #scope: Scope

  # TODO remove this into its own thing
  # if isScope:
  #   scope = newScope(scopeName, scopeDescription)

  # if inscope.len > 0 and isScope:
  #   inscopeFile = open(inscope, fmRead)
  #   defer: inscopeFile.close()
  #   for line in inscopeFile.lines:
  #     scope.inScopeAdd(line)

  # if outscope.len > 0 and isScope:
  #   outscopeFile = open(outScope, fmRead)
  #   defer: outscopeFile.close()
  #   for line in outscopeFile.lines:
  #     scope.outScopeAdd(line)


  if options.len == 0:
    option = newJobject()
  else:
    option = options.parseJson
  #if isScope:
  #  option = %*scope
  if bulk == true:
    # NOTE a different script needs to be made it can read a bunch of targets, but only one set of options is set.
    # the targets file should be one target per line, only supports txt files
    let targetFile = open(input, fmRead)
    defer: targetFile.close
    for line in targetFile.lines:
      var jdoc = %*(newTarget(dataset, target, actor, delay, recurring, option))
      jdoc["_id"] = jdoc["id"]
      jdoc.delete("id")
      echo $jdoc

  else:
    let target = newTarget(dataset, target, actor, delay, recurring, option)
    var jdoc = %*target
    jdoc["_id"] = newJString(target.id)
    jdoc.delete("id")
    echo $jdoc
