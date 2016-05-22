path = require 'path'
util = require './util'
Q = require 'q'
handlebars = require 'handlebars'
partials = require './partials'
{args, bt, classBacktick} = require './helpers'

module.exports = class MarkdownGenerator

  constructor : ( {@path, @template, @templateDir} ) ->
    throw new Error 'Missing option: path' unless @path?
    @template ?= 'default'
    @templateDir ?= path.join(__dirname, '../template', @template)

    @initialized = @load @path
    .then @loadTemplates
    .then @_registerPartials
    .then @_createView

    @initialized.done() # throw any errors

  _registerPartials : =>
    for p in partials
      handlebars.registerPartial p, @templates[ p ]

  load : =>
    util.readFile @path, 'utf8'
    .then ( contents ) => @api = JSON.parse contents

  loadTemplates : =>
    @templates = {}
    list = partials.concat 'api'
    Q.all (for item in list
      do ( item ) =>
        file = path.join @templateDir, "#{item}.hbs"
        util.readFile file, 'utf8'
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
      m.args = args m.arguments for m in klass.events
      klass

  generateMarkdown : ( outdir ) =>
    @initialized.then =>
      markdown = @templates.api @view
      classBacktick markdown
        
        
        
        
        
        
      
      
      
  
    
    
    