assert = require('chai').assert
pathToUrl = require '../pathToUrl'

describe 'pathToUrl', ->
  it 'converts Windows paths to a url path', ->
    urlPath = pathToUrl "\\Foo\\bar\\baz"
    assert.equal urlPath, '/Foo/bar/baz'

  it 'does not affect unix paths', ->
    unixPath = pathToUrl '/Foo/bar/baz/'
    assert.equal unixPath, '/Foo/bar/baz/'

  it 'normalizes path segments', ->
    joinedPath = pathToUrl '/','//Foo', 'bar', 'baz/'
    assert.equal joinedPath, '/Foo/bar/baz/'
