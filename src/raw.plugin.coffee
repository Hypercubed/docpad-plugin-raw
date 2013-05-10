# Export Plugin
module.exports = (BasePlugin) ->
	# Define Plugin
	class raw extends BasePlugin
		# Plugin name
		name: 'raw'

		# Writing all files has finished
		writeAfter: (opts,next) ->
            # Prepare
            docpad = @docpad
            config = docpad.getConfig()
            balUtil = require('bal-util')
            rawPath = config.srcPath+'/raw/*'
            # the trailing / indicates to cp that the files of this directory should be copied over
            # rather than the directory itself

            command = ['cp', '-Rn', rawPath, config.outPath+'/']
            docpad.log('debug', 'Copying raw directory')
            balUtil.spawn command, {output:true}, (err) ->
                # return next(err)  if err
                docpad.log('debug', 'Copied raw directory')
                return next()
