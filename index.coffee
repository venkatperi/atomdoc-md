require 'coffee-script/register'
generate = require './lib/generate'
generate.MarkdownGenerator = require './lib/MarkdownGenerator'

module.exports = generate