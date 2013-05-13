eachr = require('eachr')

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
			
			# Set out directories
			# the trailing / indicates to cp that the files of this directory should be copied over
			# rather than the directory itself
			if winNotCygwin
				outPath = config.outPath+'\\'
			else
				outPath = config.outPath+'/'
			
			config.plugins or= {}
			config.plugins.raw or= {}
			
			config.plugins.raw.commands or= (if winNotCygwin
				{ raw: ['xcopy', '/e', '/q'] }
			else
				{ raw: ['cp', '-Rn'] } )
			
			eachr config.plugins.raw.commands, (command, key) ->
				rawPath = config.srcPath + (if winNotCygwin
					'\\'+key+'\\*'
				else
					'/'+key+'/*' )
				
				command = command.concat([rawPath, outPath]);
				
				docpad.log('info', 'Copying '+key+' directory ['+command.join(' ')+']')
				
				balUtil.spawn command, {output:true}, (err) ->
					return next(err)  if err
					docpad.log('debug', 'Copied raw directory')
					return next()
