Q = require 'q'

###
Public: execute the given function and time the execution.
  
Returns {Promise} which resolves with an array: 
  * 0: result of the function
  * 1: time as returned by `hrtime()`
###
module.exports = ( f, args... ) ->
  start = process.hrtime()
  ret = f.apply null, args...
  Q(ret).then ( res ) ->
    end = process.hrtime start
    [ res, end ]