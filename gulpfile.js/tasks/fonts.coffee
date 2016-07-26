config      = require '../config'
if !config.tasks.fonts
  return

browserSync = require 'browser-sync'
changed     = require 'gulp-changed'
gulp        = require 'gulp'
path        = require 'path'

paths =
  src: path.join \
    config.root.src,
    config.tasks.fonts.src,
    "/**/*.{#{config.tasks.fonts.extensions}}"
  dest: path.join \
    config.root.dest,
    config.tasks.fonts.dest

fontsTask = ->
  return gulp.src [paths.src, '*!README.md']
    .pipe changed paths.dest # Ignore unchanged files
    .pipe gulp.dest paths.dest
    .pipe browserSync.stream()

gulp.task('fonts', fontsTask)
module.exports = fontsTask
