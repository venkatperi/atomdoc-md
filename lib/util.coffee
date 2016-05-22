_ = require 'lodash'
Q = require 'q'
fs = require 'fs'

STAT_TYPE = [ 'File', 'Directory', 'BlockDevice',
  'CharacterDevice', 'FIFO', 'Socket' ]

dfs =
  readFile : Q.denodeify fs.readFile
  stat : Q.denodeify fs.stat

exists = ( path, type ) ->
  type = _.capitalize type
  throw new Error 'Unknown type' unless type in STAT_TYPE
  dfs.stat path
  .then ( stat ) ->
    return unless type
    stat[ "is#{type}" ]()
  .fail ( err ) ->
    return if err.code is 'ENOENT'
    throw err

clamp = ( x, min, max ) ->
  if x < min then min else if x > max then max else x

module.exports =
  readFile : dfs.readFile
  stat : dfs.stat
  exists : exists
  clamp : clamp