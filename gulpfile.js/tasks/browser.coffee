gulp   = require 'gulp'
open   = require 'gulp-open'
config = require '../config'

taskConfig = config.tasks.browser

browserTask = (cb) ->
  gulp.src __filename
    .pipe open taskConfig


gulp.task 'browser', browserTask
module.exports = browserTask
