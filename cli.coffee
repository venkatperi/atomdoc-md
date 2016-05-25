module.exports = require 'yargs'
.command 'generate <module>',
  'generate api markdown docs for the given module'

  module :
    describe : 'path to module'

  doc :
    describe : 'docs directory'
    alias : 'o'
    default : 'doc'

  level :
    alias : 'l'
    describe : 'log level'
    default : 'info'
    choices : [ 'debug', 'verbose', 'info', 'warn', 'error' ]

  template :
    default : 'api'
    describe : 'template name'

  meta :
    describe : 'write donna (donna.json) and tello (tello.json) metadata to' +
      ' doc dir'

  name :
    describe : 'generated file name'
    alias : 'n'
    default : 'api.md'

.demand 1, 'command missing'
.strict()
.version()
.argv
 
