#!/usr/bin/env node

/* istanbul ignore next */
try {
  require( '../dist' )( process.argv )
} catch ( err ) {
  if ( err.code === 'MODULE_NOT_FOUND' ) {
    require( 'coffee-script/register' )
    require( '../index' )( process.argv )
  } else {
    console.log( err )
  }
}
