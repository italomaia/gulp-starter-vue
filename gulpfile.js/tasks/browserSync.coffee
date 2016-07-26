if global.production
  return

browserSync       = require 'browser-sync'
gulp              = require 'gulp'
webpack           = require 'webpack'
webpackMutiConfig = require '../lib/webpack-multi-config'
config            = require '../config'
pathToUrl         = require '../lib/pathToUrl'

browserSyncTask = ->
  webpackConfig = webpackMutiConfig 'development'
  compiler = webpack webpackConfig
  proxyConfig = config.tasks.browserSync.proxy or null

  if typeof(proxyConfig) == 'string'
    config.tasks.browserSync.proxy = target : proxyConfig

  server = config.tasks.browserSync.proxy or config.tasks.browserSync.server

  server.middleware = [
    require('webpack-dev-middleware')(compiler,
      stats: 'errors-only'
      publicPath: pathToUrl '/', webpackConfig.output.publicPath
    ),
    require('webpack-hot-middleware')(compiler)
  ]

  browserSync.init config.tasks.browserSync

gulp.task 'browserSync', browserSyncTask
module.exports = browserSyncTask
