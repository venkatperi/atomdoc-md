# API

## PathSearcher
Will search through paths specified for a regex.

Like the `{PathScanner}` the `{PathSearcher}` keeps no state. You need to consume
results via the done callbacks or events.

File reading is fast and memory efficient. It reads in 10k chunks and writes
over each previous chunk. Small object creation is kept to a minimum during
the read to make light use of the GC.

### Properties


### Methods

#### constructor(options)

Construct a `{PathSearcher}` object.

* **options** `{Object}`
  * **maxLineLength** `{Number}` default `100`; The max length of the `lineText`  component in a results object. `lineText` is the context around the matched text.
  * **wordBreakRegex** `{RegExp}` default `/[ \r\n\t;:?=&\/]/`;  Used to break on a word when finding the context for a match.

Construct a `{PathSearcher}` object.

#### searchPaths(regex[, paths], doneCallback)

Search an array of paths.

* **regex** `{RegExp}` search pattern
* **paths** `{Array}` of `{String}` file paths to search
* **doneCallback** called when searching the entire array of paths has finished
  * **results** `{Array}` of Result objects in the format specified above;  null when there are no results
  * **errors** `{Array}` of errors; null when there are no errors. Errors will  be js Error objects with `message`, `stack`, etc.

Search an array of paths.

Will search with a `{ChunkedExecutor}` so as not to immediately exhaust all
the available file descriptors. The `{ChunkedExecutor}` will execute 20 paths
concurrently.

#### searchPath(regex, filePath[, doneCallback])

Search a file path for a regex

* **regex** `{RegExp}` search pattern
* **filePath** `{String}` file path to search
* **doneCallback** called when searching the entire array of paths has finished
  * **results** `{Array}` of Result objects in the format specified above;  null when there are no results
  * **error** `{Error}`; null when there is no error

Search a file path for a regex


### Events

#### results-found(results)

Fired when searching for a each path has been completed and matches were found.

* **results** `{Object}` in the result format:
```js
{
  "path": "/Some/path.txt",
  "matches": [{
    "matchText": "Text",
    "lineText": "Text in this file!",
    "lineTextOffset": 0,
    "range": [[9, 0], [9, 4]]
  }]
}
```

Fired when searching for a each path has been completed and matches were found.

#### results-not-found(filePath)

Fired when searching for a path has finished and _no_ matches were found.

* **filePath** path to the file nothing was found in `"/Some/path.txt"`

Fired when searching for a path has finished and _no_ matches were found.

#### file-error(error)

Fired when an error occurred when searching a file. Happens for example when a file cannot be opened.

* **error** `{Error}` object

Fired when an error occurred when searching a file. Happens for example when a file cannot be opened.
