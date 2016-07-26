config = require '../config'
gulp   = require 'gulp'
path   = require 'path'
watch  = require 'gulp-watch'

watchTask = ->
  watchableTasks = [
    'fonts'
    'iconFont'
    'images'
    'svgSprite'
    'html'
    'css'
  ]

  watchableTasks.forEach (taskName) ->
    task = config.tasks[taskName]
    if task
      extensionsStr = task.extensions.join ','
      glob = path.join \
        config.root.src,
        task.src,
        "**/*.{#{extensionsStr}}"

      watch glob, -> require("./#{taskName}")()

gulp.task 'watch', ['browserSync'], watchTask
module.exports = watchTask
