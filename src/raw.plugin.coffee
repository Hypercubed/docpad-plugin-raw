

# Export Plugin
module.exports = (BasePlugin) ->
	# Requires
	eachr = require('eachr')
	ncp = require('ncp')
	balUtil = require('bal-util')
	path = require('path')

	# Define Plugin
	class raw extends BasePlugin
		# Plugin name
		name: 'raw'

		# Writing all files has finished
		writeAfter: (opts,next) ->
			# Prepare
			docpad = @docpad
			config = docpad.getConfig()

			# Set out directory
			# the trailing / indicates to cp that the files of this directory should be copied over
			# rather than the directory itself
			outPath = path.normalize "#{config.outPath}"
			srcPath = path.normalize "#{config.srcPath}"

			config.plugins or= {}
			config.plugins.raw or= {}

			if Object.keys(config.plugins.raw).length is 0
				config.plugins.raw.default = {}
				config.plugins.raw.default.src = 'raw'

			eachr config.plugins.raw, (target, key) ->
				docpad.log "info", "Copying #{key}"

				# Use command if specified instead of ncp
				if target.command
					WINDOWS = /win/.test(process.platform)
					CYGWIN = /cygwin/.test(process.env.PATH)  # Cheap test!
					XCOPY = WINDOWS && !CYGWIN

					target.command or= (if XCOPY
          	['xcopy', '/e', 'src\\raw\\*', 'out\\']
          else
          	['cp', '-Rn', 'src/raw/*', 'out/' ] )

					command = target.command.map (part) ->
						part.replace(/^out/, outPath).replace(/^src/, srcPath)

					balUtil.spawn command, {output:false}, (err) ->
						return next(err) if err
						docpad.log 'debug', "Copied raw directory"
						return next()

				# Otherwise use ncp by default
				else
					src = path.join srcPath, target.src

					# Use ncp settings if specified
					options = if target.options? and typeof target.options is 'object' then target.options else {}

					docpad.log 'debug', "raw plugin info... out: #{outPath}, src: #{src}, options: #{JSON.stringify(options)}"

					ncp src, outPath, options, (err) ->
						return next(err) if err
						docpad.log 'debug', "Done copying #{key}"
						return next()