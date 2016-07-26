module.exports = (pattern, number) ->
  string = ''
  while number > 0
    number--
    string += pattern
  return string
