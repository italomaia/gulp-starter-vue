path = require 'path'
fs   = require 'fs'

module.exports = (publicPath, dest, filename) ->
  filename = filename || 'rev-manifest.json'

  return ->
    this.plugin 'done', (stats) ->
      stats    = stats.toJson()
      chunks   = stats.assetsByChunkName
      manifest = {}

      for key in chunks
        originalFilename = "#{key}.js"
        chunksPath = path.join publicPath, chunks[key]
        manifest[path.join publicPath, originalFilename] = chunksPath

      fs.writeFileSync \
        path.join(process.cwd(), dest, filename),
        JSON.stringify(manifest)
