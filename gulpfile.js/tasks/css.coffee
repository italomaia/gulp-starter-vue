config       = require '../config'
if !config.tasks.css
  return

gulp         = require 'gulp'
gulpif       = require 'gulp-if'
browserSync  = require 'browser-sync'
sass         = require 'gulp-sass'
sourcemaps   = require 'gulp-sourcemaps'
handleErrors = require '../lib/handleErrors'
autoprefixer = require 'gulp-autoprefixer'
path         = require 'path'
cssnano      = require 'gulp-cssnano'

extensions = "/**/*.{#{config.tasks.css.extensions}}"
paths =
  src:  path.join config.root.src, config.tasks.css.src, extensions
  dest: path.join config.root.dest, config.tasks.css.dest

cssTask = ->
  return gulp.src(paths.src)
    .pipe gulpif !global.production, sourcemaps.init()
    .pipe sass config.tasks.css.sass
    .on 'error', handleErrors
    .pipe autoprefixer config.tasks.css.autoprefixer
    .pipe gulpif global.production, cssnano autoprefixer: false
    .pipe gulpif !global.production, sourcemaps.write()
    .pipe gulp.dest paths.dest
    .pipe browserSync.stream()

gulp.task 'css', cssTask
module.exports = cssTask
