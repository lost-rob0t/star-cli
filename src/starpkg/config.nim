import parsecfg
import os
import strutils

type
  StarConfig* = object
    database*: string
    targetdb*: string
    dbUser*: string
    dbPass*: string
    dbHost*: string
    dbPort*: int
    verbose*: bool
    defaultDataset*: string
    routerApiAddress*: string
    routerPubAddress*: string

let DEFAULT_CONFIG* = expandTilde("~/.config/starintel/config.ini")



proc loadConfigFile*(path: string): StarConfig =
  let c = loadConfig(expandTilde(path))
  let database = c.getSectionValue("DB", "database")
  let targetdb = c.getSectionValue("DB", "targetdb")
  let dbUser = c.getSectionValue("DB", "user")
  let dbPass = c.getSectionValue("DB", "password")
  let dbHost = c.getSectionValue("DB", "host")
  let dbPort = c.getSectionValue("DB", "port").parseInt
  let verbose = c.getSectionValue("MAIN", "verbose").parseBool
  let defaultDataset = c.getSectionValue("MAIN", "default-dataset")
  let apiAddr = c.getSectionValue("ROUTER", "api-address")
  let pubAddr = c.getSectionValue("ROUTER", "pub-address")
  result = StarConfig(database: database,
                  targetdb: targetdb,
                  dbUser: dbUser,
                  dbPass: dbPass,
                  dbHost: dbHost,
                  dbPort: dbPort,
                  defaultDataset: defaultDataset,
                  routerApiAddress: apiAddr,
                  routerPubAddress: pubAddr,)
# TODO write config if not found!
