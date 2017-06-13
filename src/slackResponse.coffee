gm  = require 'gm'

# container class
# mostly to make unit testing easier
class SlackResponse
  constructor: () ->
    @message = null
    @imgResult = null
    @fileName = null
    @fileDesc = null

  setMessage: (msg) ->
    @message = msg

  setUpload: (imgResult, fileDesc) ->
    @imgResult = imgResult
    @fileDesc = fileDesc

  respond: (slackResponseObject) ->
    slackResponseObject.send @message if @message
    @imgResult && @upload(slackResponseObject, @imgResult.imgPath(), @fileDesc)

  # TODO: remove hubot dependency
  upload: (slackResponseObject, filename, label) ->
    robot = slackResponseObject.robot
    # slack API for file.upload

    # get upload type and go
    gm(filename).format (err, fmt) =>
      format = if err then 'gif' else fmt
      contentOpts =
          #content: fs.readFileSync(tmpPath), # doesn't work with binary
          file: fs.createReadStream(filename)
          channels: slackResponseObject.message.room,
          fileType: format # TODO: figure it out

      robot.adapter.client.web.files.upload "#{label}.gif", contentOpts, (fileUploadErr, resp) =>
        console.log(resp)
        @imgResult.cleanup()


module.exports = SlackResponse