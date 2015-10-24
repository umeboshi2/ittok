$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Models = require 'models'

MainChannel = Backbone.Radio.channel 'global'


class KottiClipboard extends Backbone.Collection
  # initialize copy_status with "copy"
  copy_status: 'copy'

  _add_models: (models, command) ->
    @reset()
    @add models
    @copy_status = command
    
  copy: (models) ->
    @_add_models models, 'copy'

  cut: (models) ->
    @_add_models models, 'cut'

  paste: () ->
    # copy models
    models = @.models.slice()
    # empty collection
    @reset()
    # return models
    models

kotti_clipboard = new KottiClipboard
MainChannel.reply 'main:app:kotti-clipboard', ->
  kotti_clipboard
  

class KottiContents extends Backbone.Collection


  
module.exports = KottiClipboard


