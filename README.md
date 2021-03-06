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
Set as many sources as you want. Path should be relative to the `src` directory. The out folder specified in docpad.coffee is used for the destination.

If no configuration is specified, defaults to `raw` folder

```
# ...
plugins:
    raw:
        raw:
            src: 'raw'
        app:
            src: 'app'
# ...
```

You can also specify copy options as specified by ncp package

```
# ...
plugins:
    raw:
        raw:
            src: 'raw'
            options:
                clobber: false
# ...
```

If you would rather use a shell command

```
# ...
plugins:
    raw:
        raw:
            command: ['rsync', '-a', './src/raw/', './out/']
# ...
```

## Deployment Notes

Using ncp should make this plugin work on a wide variety of platforms and hosted platforms such as Heroku

## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2013+ J. Harshbarger
