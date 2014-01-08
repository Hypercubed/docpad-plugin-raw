

# Export Plugin
module.exports = (BasePlugin) ->
	# Requires
	eachr = require('eachr')
	ncp = require('ncp')
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
				# Construct the source path.
				src = path.join srcPath, target.src

				docpad.log "info", "Copying #{key}"

				# Use ncp settings if specified
				options = if target.options? and typeof target.options is 'object' then target.options else {}

				docpad.log "debug", "raw plugin info... out: #{outPath}, src: #{src}, options: #{JSON.stringify(options)}"

				ncp src, outPath, options, (err) ->
					return next(err) if err
					docpad.log "info", "Done copying #{key}"
					return next()




