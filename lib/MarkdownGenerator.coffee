path = require 'path'
{readFile, writeFile} = require './util'
Q = require 'q'
handlebars = require 'handlebars'
partials = require './partials'
{args, bt, classBacktick} = require './helpers'
mkdirp = Q.denodeify require('mkdirp')

module.exports = class MarkdownGenerator

  constructor : ( {@api, @path, @outdir, @name, @template, @templateDir} ) ->
    if !@path and !@api
      throw new Error 'Need either api or path to api'

    @template ?= 'default'
    @templateDir ?= path.join(__dirname, '../template', @template)

    p = if @path then @load(@path) else Q(true)
    @initialized = p
    .then @loadTemplates
    .then @_registerPartials
    .then @_createView

    @initialized.done() # throw any errors

  _registerPartials : =>
    for p in partials
      handlebars.registerPartial p, @templates[ p ]

  load : =>
    readFile @path, 'utf8'
    .then ( contents ) => @api = JSON.parse contents

  loadTemplates : =>
    @templates = {}
    list = partials.concat 'api'
    Q.all (for item in list
      do ( item ) =>
        file = path.join @templateDir, "#{item}.hbs"
        readFile file, 'utf8'
        .then ( src ) => handlebars.compile src
        .then ( tpl ) => @templates[ item ] = tpl )

  _createView : =>
    @view = {}
    @view.classes = for own name, klass of @api.classes
      for cat in [ 'Methods', 'Properties' ]
        all = klass[ "all#{cat}" ] = []
        for type in [ 'class', 'instance' ]
          for m in klass[ "#{type}#{cat}" ] ? []
            m.args = args m.arguments
            all.push m
      m.args = (args m.arguments for m in klass.events ? [])
      klass

  _ensureOutputDir : =>
    mkdirp @outdir

  generateMarkdown : () =>
    @initialized.then @_ensureOutputDir
    .then =>
      markdown = @templates.api @view
      classBacktick markdown
    .then ( output ) =>
      file = path.join @outdir, "#{@name}"
      writeFile file, output 

        
        
        
        
        
        
      
      
      
  
    
    
    