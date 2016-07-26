config = require('../../config')
if !config.tasks.iconFont
  return

gulp             = require 'gulp'
iconfont         = require 'gulp-iconfont'
generateIconSass = require './generateIconSass'
handleErrors     = require '../../lib/handleErrors'
pkg              = require '../../../package.json'
path             = require 'path'
url              = require 'url'

fontPath = path.join config.root.dest, config.tasks.iconFont.dest
cssPath = path.join config.root.dest, config.tasks.css.dest

settings =
  name: "#{pkg.name} icons"
  src: path.join config.root.src, config.tasks.iconFont.src, '/*.svg'
  dest: path.join config.root.dest, config.tasks.iconFont.dest
  sassDest: path.join \
    config.root.src, config.tasks.css.src, config.tasks.iconFont.sassDest
  template: path.normalize './gulpfile.js/tasks/iconFont/template.sass'
  sassOutputName: '_icons.sass',
  fontPath: url.resolve '.', path.relative cssPath, fontPath
  className: 'icon'
  options:
    timestamp: 0 # see https://github.com/fontello/svg2ttf/issues/33
    fontName: 'icons'
    normalize: false
    formats: config.tasks.iconFont.extensions

iconFontTask = ->
  return gulp.src settings.src
    .pipe iconfont settings.options
    .on 'glyphs', generateIconSass settings
    .on 'error', handleErrors
    .pipe gulp.dest settings.dest

gulp.task 'iconFont', iconFontTask
module.exports = iconFontTask
