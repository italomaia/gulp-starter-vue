config       = require '../config'
if !config.tasks.html
  return

browserSync  = require 'browser-sync'
data         = require 'gulp-data'
gulp         = require 'gulp'
gulpif       = require 'gulp-if'
handleErrors = require '../lib/handleErrors'
htmlmin      = require 'gulp-htmlmin'
path         = require 'path'
render       = require 'gulp-nunjucks-render'
fs           = require 'fs'

excludeFolders = config.tasks.html.excludeFolders.join ','
exclude = path.normalize "!**/{#{excludeFolders}}/**"

paths =
  src: [
    path.join \
      config.root.src,
      config.tasks.html.src,
      "/**/*.{#{config.tasks.html.extensions}}"
    exclude
  ]
  dest: path.join \
    config.root.dest,
    config.tasks.html.dest

getData = (file) ->
  dataPath = path.resolve \
    config.root.src,
    config.tasks.html.src,
    config.tasks.html.dataFile
  JSON.parse fs.readFileSync dataPath, 'utf8'

htmlTask = ->
  gulp.src paths.src
    .pipe data getData
    .on 'error', handleErrors
    .pipe render
      path: [path.join(config.root.src, config.tasks.html.src)]
      envOptions: watch: false
    .on 'error', handleErrors
    .pipe gulpif global.production, htmlmin config.tasks.html.htmlmin
    .pipe gulp.dest paths.dest
    .pipe browserSync.stream()

gulp.task 'html', htmlTask
module.exports = htmlTask
