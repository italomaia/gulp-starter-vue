config       = require '../config'
gulp         = require 'gulp'
repeatString = require '../lib/repeatString'
sizereport   = require 'gulp-sizereport'

gulp.task 'size-report', ->
  return gulp.src ["#{config.root.dest}/**/*", '*!rev-manifest.json']
    .pipe sizereport gzip: true
