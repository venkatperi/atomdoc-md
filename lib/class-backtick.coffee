module.exports = ( str ) ->
  replacer = ( match, p..., offset, string ) ->
    "`#{p[ 0 ]}`"

  str.replace /({\w+})/g, replacer