args = ( list ) ->
  (for a,i in list ? []
    first = i is 0
    opt = a.isOptional
    name = if first then a.name else ", #{a.name}"
    if opt then "[#{name}]" else name
  ).join ''

bt = ( str ) -> "`#{str}`"

classBacktick = ( str ) ->
  replacer = ( match, p..., offset, string ) ->
    "`#{p[ 0 ]}`"
  str.replace /({\w+})/g, replacer

module.exports =
  args : args
  bt : bt
  classBacktick : classBacktick

