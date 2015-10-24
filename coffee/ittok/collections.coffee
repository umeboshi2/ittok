$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Models = require 'models'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'


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
  
class BaseCollection extends Backbone.Collection
  # wrap the parsing to retrieve the
  # 'data' attribute from the json response
  parse: (response) ->
    return response.data

class ContentsModel extends Models.BaseKottiModel
  idAttribute: 'oid'
  
class KottiContents extends BaseCollection
  #model: Models.BaseKottiModel
  model: ContentsModel
  url: ->
    "#{@resource_id}/@@contents-json"


ResourceChannel.reply 'get-document-contents', (resource_id) ->
  # if resource_id is null, set to root resource
  resource_id ?= ''
  #console.log "get-document-contents", resource_id
  #new KottiContents resource_id: resource_id
  collection = new KottiContents
  collection.resource_id = resource_id
  collection
  

  
module.exports = KottiClipboard


