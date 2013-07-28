# Raw Files Plugin for [DocPad](http://docpad.org)
Copies all files in the raw directory to out.  Useful for large files that cause out of memory error when placed in files directory.


[![NPM version](https://badge.fury.io/js/docpad-plugin-raw.png)](http://badge.fury.io/js/docpad-plugin-raw)

[![Gittip donate button](http://badgr.co/gittip/hypercubed.png)](https://www.gittip.com/hypercubed/ "Donate weekly to this project using Gittip")
[![Paypal donate button](http://badgr.co/paypal/donate.png?bg=%23feb13d)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=X7KYR6T9U2NHC "One time donation to this project using Paypal")

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
```

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

`['cp', '-Rnl'...` will create hard links on unix-like systems.

Another example tested in Windows/DOS:

```
# ...
plugins:
    raw:
        commands:
            raw: ['rsync', '-a', './src/raw/', './out/' ]
# ...
```

## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2013+ J. Harshbarger
