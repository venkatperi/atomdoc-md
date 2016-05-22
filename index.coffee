donna = require 'donna'
path = require 'path'
tello = require 'tello'
MarkdownGenerator = require './lib/MarkdownGenerator'

argv = require 'yargs'
.command 'generate <module>',
  'generate api markdown docs for the given module'
  module :
    describe : 'path to module'
  output :
    describe : 'output directory'
    alias : 'o'
    default : 'doc'
  name :
    describe : 'name of the api markdown file'
    alias : 'n'
    default : 'api.md'
.demand 1, 'command missing'
.strict()
.argv

outdir = path.join argv.module, argv.output
metadata = donna.generateMetadata [ argv.module ]
apiData = tello.digest metadata

new MarkdownGenerator(api : apiData, outdir : outdir, name : argv.name)
.generateMarkdown()
.fail ( err ) -> console.log err
  
