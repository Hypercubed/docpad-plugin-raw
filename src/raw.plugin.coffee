

# Export Plugin
module.exports = (BasePlugin) ->
	# Requires
	eachr = require('eachr')
	path = require('path')
	balUtil = require('bal-util')
	
	# Define Plugin
	class raw extends BasePlugin
		# Plugin name
		name: 'raw'

		# Writing all files has finished
		writeAfter: (opts,next) ->
			# Prepare
			docpad = @docpad
			config = docpad.getConfig()
			
			WINDOWS = /win/.test(process.platform)
			CYGWIN = /cygwin/.test(process.env.PATH)  # Cheap test!
			XCOPY = WINDOWS && !CYGWIN
			
			# Set out directory
			# the trailing / indicates to cp that the files of this directory should be copied over
			# rather than the directory itself
			outPath = path.normalize "#{config.outPath}"
			srcPath = path.normalize "#{config.srcPath}"
			
			config.plugins or= {}
			config.plugins.raw or= {}
			
			config.plugins.raw.commands or= (if XCOPY
				{ raw: ['xcopy', '/e', 'src\\raw\\*', 'out\\'] }
			else
				{ raw: ['cp', '-Rn', 'src/raw/*', 'out/', ] } )
			
			eachr config.plugins.raw.commands, (command, key) ->
				command = command.map (part) ->
					part.replace(/^out/, outPath).replace(/^src/, srcPath)
				
				#console.log(command)
				
				docpad.log('info', 'Copying '+key)
				
				balUtil.spawn command, {output:false}, (err) ->
					return next(err)  if err
					docpad.log('debug', 'Copied raw directory')
					return next()
