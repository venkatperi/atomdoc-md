_ = require 'lodash'
path = require 'path'
{readFile, writeFile} = require './util'
Q = require 'q'
handlebars = require 'handlebars'
{args, bt, classHref} = require './helpers'
mkdirp = Q.denodeify require('mkdirp')
Template = require './Template'
log = require('taglog') "generate"
hconf = require('hconf')(module : module)

###
Public: Generates markdown from atomdoc/tello's metadata

###
module.exports = class MarkdownGenerator

  ###
  Public: Create a new markdown generator

  * `options` {Object}
    * `options.api` is an {Object} with `tello` api metadata.
    * `options.path` {String} path to file with `tello` api info
    * `options.docdir` {String} dir to write the output to. Also looks
    for files to import (e.g. `intro.md`).
    * `options.template` {String} name of the template to use
    * `options.templatePath` {String} alternatively, path to template dir
  ###
  constructor : ( {
  @api, @path, @docdir, @name,
  @template, @templatePath
  } ) ->
    if !@path and !@api
      throw new Error 'Need either api or path to api'

    @initialized = hconf.get "atomdoc-md"
    .then ( cfg ) =>
      log.v 'config', cfg
      @config = cfg
      @template = new Template
        name : @template,
        path : @templatePath
        docdir : @docdir
      (if @path then @_load(@path) else Q(true))
      .then => @template.initialized
      .then @_createView
  #@initialized.done() # throw any errors

  _load : =>
    readFile @path, 'utf8'
    .then ( contents ) => @api = JSON.parse contents

  _loadSections : =>
    @_sections = {}
    Q.all (for s in @config.sections when s isnt @config.template.main
      do ( s ) =>
        file = path.join @docdir, "s.#{@config.template.ext}"
        exists file
        .then ->
          readFile file, 'utf8'
        .then ( contents ) =>
          if contents?
            @_sections[ s ] = contents)

  _createView : =>
    log.d 'createView'
    @view = {}
    @view.classes = for own name, klass of @api.classes
      klass.isPublic = klass.visibility is 'Public'
      for cat in [ 'Methods', 'Properties' ]
        all = klass[ "all#{cat}" ] = []
        for type in [ 'class', 'instance' ]
          for m in klass[ "#{type}#{cat}" ] ? []
            m.isPublic = m.visibility is 'Public'
            m.isMethod = cat is 'Methods'
            m.isInstance = type is 'instance'
            m.association = type
            m.args = args m.arguments
            all.push m
      m?.args = (args m.arguments for m in klass.events ? [])
      klass

  _ensureOutputDir : =>
    log.d 'ensureOutputDir'
    mkdirp @docdir

  ###
  Public: Writes markdown to the output file. 
  
  Returns a {Promise} which resolves with the generated
  {String} when done.
  ###
  generateMarkdown : () =>
    @initialized.then @_ensureOutputDir
    .then =>
      log.d 'rendering view'
      md = @template.render @view
      if @config.generator[ "href for objects" ]
        md = classHref @api, md, @config.generator
      md
    .then ( output ) =>
      file = path.join @docdir, "#{@name}"
      log.v 'writing file', file
      writeFile file, output
      output

        
