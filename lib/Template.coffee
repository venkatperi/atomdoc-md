_ = require 'lodash'
path = require 'path'
Q = require 'q'
{readFile} = require './util'
handlebars = require 'handlebars'
hconf = require('hconf')(module : module)

###
Internal: Handlebars template helpers
  
###
module.exports = class Template

  ###
  Internal: Create a {Template} helper object

  * `@name` (optional) {String} is a builtin template name
  * `@path` (optional) load a template from {String} path
  
  ###
  constructor : ( {@name, @path} ) ->
    @initialized = hconf
    .get 'atomdoc-md.template'
    .then ( cfg ) =>
      @_cfg = cfg
      @name = cfg.default if !@name and !@path
      if @name
        @path = path.join(__dirname, '../template', @name)
      @_load()

  ###
  Public: Returns a loaded handlebars
  
  * `name` {String} The template name 
  
  ###
  get : ( name ) => @templates[ name ]

  ###
  Internal: Render a view with the main template

  * `view` {Object} The view to use with the handlebars template

  Returns {String} the rendered view
  ###
  render : ( view ) =>
    @templates[ @config.templates.main ] view

  ###
  Internal: Load a template
  
  Reads template config.json, loads the main template and partials and
   registers partials.
  ###
  _load : =>
    @_loadConfig()
    .then @_loadTemplates
    .then @_registerPartials
    .then @_registerHelpers

  _loadConfig : =>
    readFile path.join(@path, @_cfg.configFile), 'utf8'
    .then ( contents ) =>
      @config = JSON.parse contents
      @config.templates.main ?= @_cfg.main
      @config.templates.ext ?=  @_cfg.ext

  _registerHelpers : =>
    handlebars.registerHelper 'toLower', ( options ) ->
      options?.fn(this).toLowerCase()

    handlebars.registerHelper 'toUpper', ( options ) ->
      options?.fn(this).toUpperCase()

    handlebars.registerHelper 'capitalize', ( options ) ->
      _.capitalize options?.fn(this)

  _registerPartials : =>
    for p in @config.templates.partials
      handlebars.registerPartial p, @templates[ p ]

  _loadTemplates : =>
    @templates = {}
    list = _.clone @config.templates.partials
    list.push @config.templates.main

    ext = @config.templates.ext
    Q.all (for item in list
      do ( item ) =>
        file = path.join @path, "#{item}.#{ext}"
        readFile file, 'utf8'
        .then ( src ) => handlebars.compile src
        .then ( tpl ) => @templates[ item ] = tpl )

