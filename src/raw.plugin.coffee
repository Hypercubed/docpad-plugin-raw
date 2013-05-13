
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
			
			winNotCygwin = /win/.test(process.platform) && !/cygwin/.test(process.env.PATH)

			# Set src and out directories
			# the trailing / indicates to cp that the files of this directory should be copied over
			# rather than the directory itself
			if winNotCygwin
				rawPath = config.srcPath+'\\raw\\*'
				outPath = config.outPath+'\\'
			else
				rawPath = config.srcPath+'/raw/*'
				outPath = config.outPath+'/'
			
			# Set copy command
			if winNotCygwin
				command = ['xcopy', '/E', rawPath, outPath]
			else
				command = ['cp', '-Rnl', rawPath, outPath]  # Hard links, is this a good idea?
			
			docpad.log('debug', 'Copying raw directory')
			balUtil.spawn command, {output:true}, (err) ->
				return next(err)  if err
				docpad.log('debug', 'Copied raw directory')
				return next()
