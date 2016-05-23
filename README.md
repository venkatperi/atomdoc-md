### API

#### Directory <sup><sub><code>CLASS</code></sub></sup>
Represents a directory on disk that can be watched for changes. 


##### Methods

###### @constructor(<code>directoryPath[, symlink]</code>)

Configures a new Directory instance, no files are accessed.

* **directoryPath** A [<code>{String}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) containing the absolute path to the directory
* **symlink** A [<code>{Boolean}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean) indicating if the path is a symlink. (default: false) 

Configures a new Directory instance, no files are accessed.
###### @create(<code>[mode]</code>)

Creates the directory on disk that corresponds to `::getPath()` if
no such directory already exists.

* **mode** [<code>{Number}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number) that defaults to `0777`.

Creates the directory on disk that corresponds to `::getPath()` if
no such directory already exists.

---
###### @onDidChange(<code>callback</code>)

Invoke the given callback when the directory's contents change.

* **callback** [<code>{Function}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function) to be called when the directory's contents change.

Invoke the given callback when the directory's contents change.

---
###### @isFile(<code></code>)






---
###### @isDirectory(<code></code>)






---
###### @isSymbolicLink(<code></code>)






---
###### @exists(<code></code>)






---
###### @existsSync(<code></code>)






---
###### @isRoot(<code></code>)

Return a [<code>{Boolean}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean), true if this [<code>{Directory}</code>](https://github.com/atom/node-pathwatcher/blob/v6.5.0/src/directory.coffee#L13) is the root directory
of the filesystem, or false if it isn't. 


Return a [<code>{Boolean}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean), true if this [<code>{Directory}</code>](https://github.com/atom/node-pathwatcher/blob/v6.5.0/src/directory.coffee#L13) is the root directory
of the filesystem, or false if it isn't. 

---
###### @getPath(<code></code>)






This may include unfollowed symlinks or relative directory entries. Or it
may be fully resolved, it depends on what you give it. 

---
###### @getRealPathSync(<code></code>)






All relative directory entries are removed and symlinks are resolved to
their final destination. 

---
###### @getBaseName(<code></code>)






---
###### @relativize(<code></code>)






---
###### @getParent(<code></code>)

Traverse to the parent directory.


Traverse to the parent directory.

---
###### @getFile(<code>filename</code>)

Traverse within this Directory to a child File. This method doesn't
actually check to see if the File exists, it just creates the File object.

* **filename** The [<code>{String}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) name of a File within this Directory.

Traverse within this Directory to a child File. This method doesn't
actually check to see if the File exists, it just creates the File object.

---
###### @getSubdirectory(<code>dirname</code>)

Traverse within this a Directory to a child Directory. This method
doesn't actually check to see if the Directory exists, it just creates the
Directory object.

* **dirname** The [<code>{String}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) name of the child Directory.

Traverse within this a Directory to a child Directory. This method
doesn't actually check to see if the Directory exists, it just creates the
Directory object.

---
###### @getEntriesSync(<code></code>)

Reads file entries in this directory from disk synchronously.


Reads file entries in this directory from disk synchronously.

---
###### @getEntries(<code>callback</code>)

Reads file entries in this directory from disk asynchronously.

* **callback** A [<code>{Function}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function) to call with the following arguments:
  * **error** An [<code>{Error}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error), may be null.
  * **entries** An [<code>{Array}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array) of [<code>{File}</code>](https://github.com/atom/node-pathwatcher/blob/v6.5.0/src/file.coffee#L18) and [<code>{Directory}</code>](https://github.com/atom/node-pathwatcher/blob/v6.5.0/src/directory.coffee#L13) objects. 

Reads file entries in this directory from disk asynchronously.

---
###### @contains(<code></code>)

Determines if the given path (real or symbolic) is inside this
directory. This method does not actually check if the path exists, it just
checks if the path is under this directory.

* **pathToCheck** The [<code>{String}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) path to check.

Determines if the given path (real or symbolic) is inside this
directory. This method does not actually check if the path exists, it just
checks if the path is under this directory.

---

#### File <sup><sub><code>CLASS</code></sub></sup>
Represents an individual file that can be watched, read from, and
written to. 


##### Methods

###### @constructor(<code>filePath, symlink</code>)

Configures a new File instance, no files are accessed.

* **filePath** A [<code>{String}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) containing the absolute path to the file
* **symlink** A [<code>{Boolean}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean) indicating if the path is a symlink (default: false). 

Configures a new File instance, no files are accessed.
###### @create(<code></code>)

Creates the file on disk that corresponds to `::getPath()` if no
such file already exists.


Creates the file on disk that corresponds to `::getPath()` if no
such file already exists.

---
###### @onDidChange(<code>callback</code>)

Invoke the given callback when the file's contents change.

* **callback** [<code>{Function}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function) to be called when the file's contents change.

Invoke the given callback when the file's contents change.

---
###### @onDidRename(<code>callback</code>)

Invoke the given callback when the file's path changes.

* **callback** [<code>{Function}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function) to be called when the file's path changes.

Invoke the given callback when the file's path changes.

---
###### @onDidDelete(<code>callback</code>)

Invoke the given callback when the file is deleted.

* **callback** [<code>{Function}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function) to be called when the file is deleted.

Invoke the given callback when the file is deleted.

---
###### @onWillThrowWatchError(<code>callback</code>)

Invoke the given callback when there is an error with the watch.
When your callback has been invoked, the file will have unsubscribed from
the file watches.

* **callback** [<code>{Function}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function) callback
  * **errorObject** [<code>{Object}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)

Invoke the given callback when there is an error with the watch.
When your callback has been invoked, the file will have unsubscribed from
the file watches.

---
###### @isFile(<code></code>)






---
###### @isDirectory(<code></code>)






---
###### @isSymbolicLink(<code></code>)






---
###### @exists(<code></code>)






---
###### @existsSync(<code></code>)






---
###### @getDigest(<code></code>)

Get the SHA-1 digest of this file


Get the SHA-1 digest of this file

---
###### @getDigestSync(<code></code>)

Get the SHA-1 digest of this file


Get the SHA-1 digest of this file

---
###### @setEncoding(<code>encoding</code>)

Sets the file's character set encoding name.

* **encoding** The [<code>{String}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) encoding to use (default: 'utf8') 

Sets the file's character set encoding name.

---
###### @getEncoding(<code></code>)






---
###### @getPath(<code></code>)






---
###### @getRealPathSync(<code></code>)






---
###### @getRealPath(<code></code>)






---
###### @getBaseName(<code></code>)

Return the [<code>{String}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) filename without any directory information. 


Return the [<code>{String}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) filename without any directory information. 

---
###### @getParent(<code></code>)

Return the [<code>{Directory}</code>](https://github.com/atom/node-pathwatcher/blob/v6.5.0/src/directory.coffee#L13) that contains this file. 


Return the [<code>{Directory}</code>](https://github.com/atom/node-pathwatcher/blob/v6.5.0/src/directory.coffee#L13) that contains this file. 

---
###### @read(<code>flushCache</code>)

Reads the contents of the file.

* **flushCache** A [<code>{Boolean}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean) indicating whether to require a direct read or if a cached copy is acceptable.

Reads the contents of the file.

---
###### @createReadStream(<code></code>)






---
###### @write(<code>text</code>)

Overwrites the file with the given text.

* **text** The [<code>{String}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) text to write to the underlying file.

Overwrites the file with the given text.

---
###### @createWriteStream(<code></code>)






---
###### @writeSync(<code></code>)

Overwrites the file with the given text.

* **text** The [<code>{String}</code>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) text to write to the underlying file.

Overwrites the file with the given text.

---

