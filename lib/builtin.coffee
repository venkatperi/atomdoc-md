globalObjects = require './globalObjects.json'
mdn = 'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/' +
  'Global_Objects'

list = {}
for name in  globalObjects
  list[name] = { srcUrl : "#{mdn}/#{name}" }

module.exports = { classes : list }