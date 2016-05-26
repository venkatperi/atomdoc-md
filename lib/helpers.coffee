builtinObj = require './builtin'

args = ( list ) ->
  (for a,i in list ? []
    first = i is 0
    opt = a.isOptional
    name = if first then a.name else ", #{a.name}"
    if opt then "[#{name}]" else name
  ).join ''

md =
  bt : ( str ) -> "`#{str}`"
  code : ( str ) -> "<code>#{str}</code>"
  link : ( name, url ) -> "<a href=\"#{url}\">#{name}</a>"
#link : ( name, url ) -> "[#{name}](#{url})"
  small : ( str ) -> "<sub><sup>#{str}</sup></sub>"

classBacktick = ( str ) ->
  replacer = ( match, p..., offset, string ) -> "`#{p[ 0 ]}`"
  str.replace /({\w+})/g, replacer

classHref = ( api, str, opts = {} ) ->
  r = ( match, p..., offset, string ) ->
    name = p[ 0 ]
    linkName = p[ 0 ]
    bname = "{#{p[ 0 ]}}"
    #linkName = md.code bname if opts[ "code tag in href" ]

    if builtinObj.classes[ name ]?
      if opts[ "href for builtin objects" ]
        url = builtinObj?.classes?[ name ]?.srcUrl
    else
      url = api?.classes?[ name ]?.srcUrl

    x = if url then md.link(linkName, url) else md.bt bname
    x = md.code x if opts[ "code tag in href" ]
    x

  str.replace /{(\w+)}/g, r

renderHeadings = ( text, level ) ->
  level += 4 if level < 4
  "<h#{level}>#{text}</h#{level}>"

repoInfo = ( repo ) ->
  return unless repo.type is 'git'
  m = /^(https?:\/\/github.com\/)?([^\/]+)\/([^\/]+?)(\.git)?$/
  .exec(repo.url or '')
  if m
    m[ 2 ] + '/' + m[ 3 ]

module.exports =
  repoInfo : repoInfo
  args : args
  md : md
  classBacktick : classBacktick
  classHref : classHref
  renderHeadings : renderHeadings
  

