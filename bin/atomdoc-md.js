#!/usr/bin/env node
require( 'coffee-script/register' );
var generate = require( '../lib/generate' );
generate( require( '../cli' ) ).done();

