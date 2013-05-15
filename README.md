# Raw Files Plugin for [DocPad](http://docpad.org)
Copies all files in the raw directory to out.  Useful for large files that cause out of memory error when placed in files directory.

## Install

```
npm install --save docpad-plugin-raw
```

## Install for testing

```
git clone https://github.com/Hypercubed/docpad-plugin-raw.git
cd docpad-plugin-raw
npm install
make compile
```

## Test

```
make test
````

## Configuration

You can change the "cp" command as follows:

```
# ...
plugins:
    raw:
        commands:
            raw: ['cp', '-Rnl', 'src/raw/*', 'out/' ]
			app: ['cp', '-Rn', 'src/app/*', 'out/' ]
# ...
```

## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2013+ J. Harshbarger
