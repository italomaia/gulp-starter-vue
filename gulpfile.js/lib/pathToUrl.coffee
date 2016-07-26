path = require 'path'

pathToUrl = ->
  # Normalizes Windows file paths to valid url paths
  return path.join
    .apply @, arguments
    .replace /\\/g, '/'

module.exports = pathToUrl
