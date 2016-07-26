config          = require '../config'
gulp            = require 'gulp'
gulpSequence    = require 'gulp-sequence'
getEnabledTasks = require '../lib/getEnabledTasks'

productionTask = (cb) ->
  global.production = true
  tasks = getEnabledTasks 'production'
  gulpSequence \
    'clean',
    tasks.assetTasks,
    tasks.codeTasks,
    if config.tasks.production.rev? then 'rev' else false,
    'size-report',
    'static',
    cb

gulp.task 'production', productionTask
module.exports = productionTask
