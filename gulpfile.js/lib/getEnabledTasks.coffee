config  = require '../config'
compact = require 'lodash/compact'

# Grouped by what can run in parallel
assetTasks = [
  'fonts'
  'iconFont'
  'images'
  'svgSprite'
]
codeTasks = [
  'html'
  'css'
  'js'
]

module.exports = (env) ->
  matchFilter = (task) ->
    if config.tasks[task]
      if task == 'js'
        task = if env == 'production' then 'webpack:production' else false
      return task

  exists = (value) -> not not value

  assetTasks:
    compact(
      assetTasks
        .map matchFilter
        .filter exists
    )
  codeTasks:
    compact(
      codeTasks
        .map matchFilter
        .filter exists
    )
