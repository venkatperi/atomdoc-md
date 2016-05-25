#atomdoc-md
Markdown generator for [atomdoc](https://github.com/atom/atomdoc).
Uses [donna]() and [tello]().

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

See samples [here](https://github.com/venkatperi/atomdoc-md).

#Usage

```
coffee index.coffee generate <module>

Options:
  --doc, -o    docs directory  [default: "doc"]
  --level, -l  log level  [choices: "debug", "verbose", "info", "warn", "error"] [default: "info"]
  --template   template name  [default: "api"]
  --meta       write donna (donna.json) and tello (tello.json) metadata to doc dir
  --name, -n   generated file name  [default: "api.md"]
```