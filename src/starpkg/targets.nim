import starintel_doc
import std/json


proc target*(dataset, target, actor: string, bulk: bool = false, input: string = "",  options: string = "") =
  var
    outputFile: File
    option: JsonNode
  if options.len == 0:
    option = newJobject()
  else:
    option = options.parseJson
  if bulk == true:
    # NOTE a different script needs to be made it can read a bunch of targets, but only one set of options is set.
    # the targets file should be one target per line, only supports txt files
    let targetFile = open(input, fmRead)
    defer: targetFile.close
    for line in targetFile.lines:
      var jdoc = %* newTarget(dataset, line, actor, option)
      jdoc["_id"] = jdoc["id"]
      jdoc.delete("id")
      echo $jdoc

  else:
    let target = newTarget(dataset, target, actor, option)
    var jdoc = %*target
    jdoc["_id"] = newJString(target.id)
    jdoc.delete("id")
    echo $jdoc
