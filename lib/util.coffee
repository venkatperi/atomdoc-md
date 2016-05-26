_ = require 'lodash'
Q = require 'q'
fs = require 'fs'

STAT_TYPE = [ 'File', 'Directory', 'BlockDevice',
  'CharacterDevice', 'FIFO', 'Socket' ]

module.exports.readJsonFile = ( file ) ->
  readFile file, 'utf8'
  .then ( data ) -> JSON.parse data

dfs = {}
for p in [ 'readFile', 'stat', 'mkdir', 'writeFile' ]
  module.exports[ p ] = dfs[ p ] = Q.denodeify fs[ p ]

module.exports.readJsonFile = ( file ) ->
  dfs.readFile file, 'utf8'
  .then ( data ) -> JSON.parse data

module.exports.exists = ( path, type = 'File' ) ->
  type = _.capitalize type
  throw new Error 'Unknown type' unless type in STAT_TYPE
  dfs.stat path
  .then ( stat ) ->
    return true unless type
    stat[ "is#{type}" ]()
  .fail ( err ) ->
    return false if err.code is 'ENOENT'
    throw err

module.exports.clamp = ( x, min, max ) ->
  if x < min then min else if x > max then max else x

