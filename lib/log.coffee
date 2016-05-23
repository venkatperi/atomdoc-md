moment = require 'moment'
replacer = ( k, v ) ->
  return '[Function]' if typeof v is 'function'
  v

levels =
  debug : 0
  verbose : 1
  info : 2
  warn : 3
  error : 4
  fatal : 5

logLevel = 'info'

log = ( level, tag ) -> ( items... ) ->
  return if levels[ level ] < levels[ logLevel ]
  msgs = for item in items
    if typeof item is 'object' then JSON.stringify item, replacer else item
  l = level[ 0 ].toUpperCase()
  time = moment().format 'hh:mm:ss:SSSS'
  console.log "#{l}/#{time}[#{tag}] #{msgs.join ' '}"

log.level = 'info'

module.exports = ( tag ) ->
  level : ( l ) -> logLevel = l
  debug : log('debug', tag)
  d : log('debug', tag)
  verbose : log('verbose', tag)
  v : log('verbose', tag)
  info : log('info', tag)
  i : log('info', tag)
  warn : log('warn', tag)
  w : log('warn', tag)
  error : log('error', tag)
  e : log('error', tag)
