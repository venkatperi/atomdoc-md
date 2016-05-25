Q = require 'q'

module.exports = ( f, args... ) ->
  start = process.hrtime()
  ret = f.apply null, args...
  Q(ret).then ( res ) ->
    end = process.hrtime start
    [ res, end ]