config = require '../config'
if !config.tasks.js
  return

path            = require 'path'
pathToUrl       = require './pathToUrl'
webpack         = require 'webpack'
webpackManifest = require './webpackManifest'

module.exports = (env) ->
  jsSrc   = path.resolve config.root.src, config.tasks.js.src
  jsDest  = path.resolve config.root.dest, config.tasks.js.dest
  publicPath = pathToUrl config.tasks.js.dest, '/'

  extensions = config.tasks.js.extensions.map \
    (extension) -> ".#{extension}"

  rev = config.tasks.production.rev and env == 'production'
  filenamePattern = if rev? then '[name]-[hash].js' else '[name].js'

  webpackConfig =
    context: jsSrc
    plugins: []
    resolve:
      root: jsSrc
      extensions: [''].concat(extensions)
    module:
      loaders: [
          test: /\.js$/
          loader: 'babel-loader'
          exclude: /node_modules/
          query: config.tasks.js.babel
      ]

  if env == 'development'
    webpackConfig.devtool = 'inline-source-map'

    # Create new entries object with webpack-hot-middleware added
    for key in config.tasks.js.entries
      entry = config.tasks.js.entries[key]
      txt = 'webpack-hot-middleware/client?&reload=true'
      config.tasks.js.entries[key] = [txt].concat(entry)

    webpackConfig.plugins.push \
      new webpack.HotModuleReplacementPlugin()

  if env != 'test'
    # Karma doesn't need entry points or output settings
    webpackConfig.entry = config.tasks.js.entries

    webpackConfig.output =
      path: path.normalize(jsDest),
      filename: filenamePattern,
      publicPath: publicPath

    if config.tasks.js.extractSharedJs
      # Factor out common dependencies into a shared.js
      webpackConfig.plugins.push \
        new webpack.optimize.CommonsChunkPlugin \
          name: 'shared',
          filename: filenamePattern

  if env == 'production'
    if rev
      webpackConfig.plugins.push \
        new webpackManifest \
          publicPath,
          config.root.dest

    webpackConfig.plugins.push \
      new webpack.DefinePlugin \
        'process.env': NODE_ENV: JSON.stringify('production'),
      new webpack.optimize.DedupePlugin(),
      new webpack.optimize.UglifyJsPlugin(),
      new webpack.NoErrorsPlugin()

  return webpackConfig
