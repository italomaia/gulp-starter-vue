notify = require "gulp-notify"

module.exports = (errorObject, callback) ->
  notify.onError \
    errorObject.toString().split(': ').join(':\n')
    .apply @, arguments
  # Keep gulp from hanging on this task
  if typeof @emit == 'function'
    @emit 'end'
