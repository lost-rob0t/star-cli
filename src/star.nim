import starpkg/config
import starpkg/database
import starpkg/router
import starpkg/targets
import tables
import cligen

when isMainModule:
  const targetHelp = {"target": "target value or path to file when in bulk mode", "dataset": "Dataset for actors to store data in (actor is a bot)",
                      "actor": "name of the actor (aka a bot name)",
                      "bulk": "Create many targets listed in the file set by target argument",
                     "options": "optional json object holding config for the actor. See the actor's documentation for what to put in here."}.toTable
  const importHelp = {"configPath": "path to config",
      "file": "path to a starintel document dump"}.toTable
  const publishHelp = {"apiAddress": "The API Address of the starRouter message queue. Defaults to tcp://127.0.0.1:6001",
                      "subAddress": "The subcription address of the starRouter message queue. Defaults to tcp://127.0.0.1:6000",
                      "path": "The file path with json lines to be sent to the message queue topic. Use /dev/stdin for pipes.",
                      "topic": "The message topic to be used.",
                      "isTarget": "Is this a target input for scanning?",
                      "actor": "The Actor for target input to be sent to, only used when isTarget is true."}.toTable
  # TODO Move this to starRouter subcommand ./star router subscribe
  const subscribeHelp = {"apiAddress": "The API Address of the starRouter message queue. Defaults to tcp://127.0.0.1:6001",
                      "subAddress": "The subcription address of the starRouter message queue. Defaults to tcp://127.0.0.1:6000",
                      "topic": "The message topic to be used.",
                          "isActor": "Is this subscriber ment to be a actor (for shell scripts)?",
                          "queueSize": "how lare (in items) to make the queue.",
                      "actor": "The name of the actor to be used. only valid when isActor is true."}.toTable
  dispatchMulti([target, help = targetHelp], [init], [insert_data], [
      publishDocuments, help = publishHelp], [subscribe, help = subscribeHelp])
