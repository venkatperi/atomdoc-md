#atomdoc-md
Markdown generator for [atomdoc](https://github.com/atom/atomdoc).
Uses [donna]() and [tello]().

See samples [here](https://github.com/venkatperi/atomdoc-md-samples).

#Installation
Install with npm
```
npm install -g atomdoc-md
```

#Examples
## Generate docs
```
atomdoc-md generate <path to module>
```


#Usage
## Command Line

```
atomdoc-md generate <module>

Options:
  --doc, -o    docs directory  [default: "doc"]
  --level, -l  log level  [choices: "debug", "verbose", "info", "warn", "error"] [default: "info"]
  --template   template name  [default: "api"]
  --meta       write donna (donna.json) and tello (tello.json) metadata to doc dir
  --name, -n   generated file name  [default: "api.md"]
```

## From Node

```coffeescript
AtomdocMD = require 'atomdoc-md'

generator = new AtomdocMD( options );
generator.generateMarkdown()
```

## Generate `README.md`
```
# From the project's root

atomdoc-md generate -o . -n README.md .
```

## Importing Files
The default template `api` will include files `intro.md` and `appendix.md` into the output.
The files must be located in the `--doc` docs directory.

