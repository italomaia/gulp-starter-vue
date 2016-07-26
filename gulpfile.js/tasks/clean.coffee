gulp   = require 'gulp'
del    = require 'del'
config = require '../config'

cleanTask = (cb) ->
  del [config.root.dest]
    .then (paths) -> cb(); return
  return


gulp.task 'clean', cleanTask
module.exports = cleanTask
