

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
				config.plugins.raw.default.src = './src/raw/'
			
			eachr config.plugins.raw, (target, key) ->
				if outPath.indexOf('./') is 0 and outPath.slice(-1) is '/'
					out = outPath

				if outPath.slice(-1) isnt '/' 
					out = "#{outPath}/"

				if outPath.indexOf('./') isnt 0
					out = if outPath.indexOf('/') is 0 then "#{outPath}/" else "./#{outPath}/"

				if target.src.indexOf('./') is 0 and target.src.slice(-1) is '/'
					src = target.src

				if target.src.slice(-1) isnt '/' 
					src = "#{target.src}/"

				if target.src.indexOf('./') isnt 0
					src = if target.src.indexOf('/') is 0 then "#{target.src}/" else "./#{target.src}/"
				
				docpad.log "debug", "raw out: #{out} and src: #{src}"
				
				docpad.log "info", "Copying #{key}"

				ncp src, out, (err) ->
					if (err)
						docpad.log "warn", "Problem syncing #{key}. Error: #{err}"
						next()
					docpad.log "info", "Done copying #{key}"
					next()					

				
				
				
