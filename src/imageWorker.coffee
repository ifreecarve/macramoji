ImageResult = require '../src/imageResult'

http = require 'http'
fs = require 'fs'
async = require 'async'

# TODO: if bubbling up an error, we should make a call stack
class ImageWorker
  # workFn will have to contain a callback that expects an imageResult
  constructor: (@children, @args, @workFn) ->
    @result = null

  # callback takes imageResult
  resolve: (callback) ->
    return callback(@result) if @result


module.exports = ImageWorker
