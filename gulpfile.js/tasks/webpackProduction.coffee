config = require '../config'
if !config.tasks.js
  return

config  = require('../lib/webpack-multi-config')('production')
gulp    = require 'gulp'
logger  = require '../lib/compileLogger'
webpack = require 'webpack'

webpackProductionTask = (callback) ->
  webpack config, (err, stats) ->
    logger err, stats
    callback()

gulp.task 'webpack:production', webpackProductionTask
module.exports = webpackProductionTask
