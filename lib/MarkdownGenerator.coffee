_ = require 'lodash'
path = require 'path'
{exists, readJsonFile, readFile, writeFile} = require './util'
Q = require 'q'
handlebars = require 'handlebars'
{repoInfo, args, bt, classHref} = require './helpers'
mkdirp = Q.denodeify require('mkdirp')
Template = require './Template'
log = require('taglog') "generate"
hconf = require('hconf')(module : module)
seqx = require 'seqx'

###
Public: Generates markdown from atomdoc/tello's metadata

###
module.exports = class MarkdownGenerator

  ###
  Public: Create a new markdown generator

  * `opt` {Object} Options
    * `opt.api` is an {Object} with `tello` api metadata.
    * `opt.path` {String} path to file with `tello` api info
    * `opt.docdir` {String} dir to write the output to. Also looks
    for files to import (e.g. `intro.md`).
    * `opt.template` {String} name of the template to use
    * `opt.templatePath` {String} alternatively, path to template dir
    * `opt.modulePath` {String} path to the module (for package.json) 
  ###
  constructor : ( {
  @api, @path, @docdir, @name,
  @template, @templatePath, @modulePath
  } ) ->
    if !@path and !@api
      throw new Error 'Need either api or path to api'
    throw new Error('Missing option: modulePath') unless @modulePath

    @initTasks = seqx.par()

    @initTasks.add [
      @_loadConfig
      @_loadTemplates
      @_getApi
      @_getPackage
      @_checkForTravis
    ]

    @initialized = @initTasks.all.then @_createView

  ###
  Public: Writes markdown to the output file.

  Returns a {Promise} which resolves with the generated
  {String} when done.
  ###
  generateMarkdown : () =>
    @initialized.then @_ensureOutputDir
    .then @_renderView
    .then @_writeOutput

  _renderView : =>
    log.d 'rendering view'
    md = @template.render @view
    if @config.generator[ "href for objects" ]
      md = classHref @api, md, @config.generator
    md

  _writeOutput : ( output ) =>
    file = path.join @docdir, "#{@name}"
    log.v 'writing file', file
    writeFile file, output
    output

  _ensureOutputDir : =>
    log.d 'ensureOutputDir'
    mkdirp @docdir

  _getApi : =>
    Q(@api or readJsonFile @path)
    .then ( api ) => @api = api

  _getPackage : =>
    readJsonFile path.join(@modulePath, 'package.json')
    .then ( data ) => @package = data

  _checkForTravis : =>
    exists path.join(@modulePath, '.travis.yml')
    .then ( val ) =>
      log.v 'has travis:', val
      @hasTravis = val

  _createView : =>
    log.d 'createView'
    if @hasTravis
      @package.travis = repoInfo @package.repository
    @view = { package : @package }

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

  _loadTemplates : =>
    @template = new Template
      name : @template,
      path : @templatePath
      docdir : @docdir
    @template.initialized

  _loadConfig : =>
    hconf.get("atomdoc-md").then ( cfg ) =>
      log.v 'config', cfg
      @config = cfg
