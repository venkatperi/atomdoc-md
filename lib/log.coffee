moment = require 'moment'
replacer = ( k, v ) ->
  return '[Function]' if typeof v is 'function'
  v

levels =
  verbose : 0
  info : 1
  warn : 2
  error : 3

logLevel = 'info'

log = ( level, tag ) -> ( items... ) ->
  return if levels[level] < levels[logLevel]
  msgs = for item in items
    if typeof item is 'object' then JSON.stringify item, replacer else item
  l = level[0].toUpperCase()
  time = moment().format 'hh:mm:ss:SSSS'
  console.log "#{l}/#{time}[#{tag}] #{msgs.join ' '}"

log.level = 'info'

module.exports = ( tag ) ->
  level : ( l ) -> logLevel = l
  verbose : log('verbose', tag)
  v : log('verbose', tag)
  info : log('info', tag)
  i : log('info', tag)
  warn : log('warn', tag)
  w : log('warn', tag)
  error : log('error', tag)
  e : log('error', tag)
