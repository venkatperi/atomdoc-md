_ = require 'lodash'
Q = require 'q'
fs = require 'fs'

STAT_TYPE = [ 'File', 'Directory', 'BlockDevice',
  'CharacterDevice', 'FIFO', 'Socket' ]

dfs = {}
for p in [ 'readFile', 'stat', 'mkdir', 'writeFile' ]
  module.exports[ p ] = dfs[ p ] = Q.denodeify fs[ p ]

module.exports.clamp = ( x, min, max ) ->
  if x < min then min else if x > max then max else x

