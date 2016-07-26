config  = require '../config'
ghPages = require 'gulp-gh-pages'
gulp    = require 'gulp'
open    = require 'open'
os      = require 'os'
pkg     = require '../../package.json'
path    = require 'path'

settings =
  url: pkg.homepage
  src: path.join config.root.dest, '/**/*'
  ghPages:
    cacheDir: path.join os.tmpdir(), pkg.name

deployTask = ->
  return gulp.src settings.src
    .pipe ghPages settings.ghPages
    .on 'end', -> open settings.url

gulp.task 'deploy', ['production'], deployTask
module.exports = deployTask
