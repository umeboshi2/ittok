$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'


MainChannel = Backbone.Radio.channel 'global'


########################################
# Models
########################################
#
class KottiMessage extends Backbone.Model
  defaults:
    level: 'info'


class KottiMessages extends Backbone.Collection
  model: KottiMessage

class BaseKottiModel extends Backbone.Model
  url: ->
    "#{@id}/@@json"

  parse: (response, options) ->
    messages = response.data.relationships.meta.messages
    for label of messages
      for msg in messages[label]
        MainChannel.request 'main:app:display-message', msg, label
    window.kotti_response = response
    window.kotti_options = options
    super response, options

class AppSettings extends Backbone.Model
  id: 'ittok'

class KottiRootDocument extends BaseKottiModel
  url: "@@json"

class KottiDefaultViewSelector extends Backbone.Model


app_settings = new AppSettings
MainChannel.reply 'main:app:settings', ->
  app_settings


#root_document = new KottiRootDocument
#MainChannel.reply 'main:app:root-document', ->
#  root_document

MainChannel.reply 'main:app:get-document', (path) ->
  new BaseKottiModel
    id: path

main_message_collection = new KottiMessages
MainChannel.reply 'main:app:messages', ->
  main_message_collection

MainChannel.reply 'main:app:display-message', (msg, lvl) =>
  messages = MainChannel.request 'main:app:messages'
  Message = new Backbone.Model
    content: msg
    level: lvl
  window.messages = messages
  messages.add Message

MainChannel.reply 'main:app:display-message', (msg, lvl) =>
  messages = MainChannel.request 'main:app:messages'
  Message = new Backbone.Model
    content: msg
    level: lvl
  window.messages = messages
  messages.add Message

MainChannel.reply 'main:app:delete-message', (model) =>
  messages = MainChannel.request 'main:app:messages'
  messages.remove model



module.exports =
  KottiMessage: KottiMessage
  AppSettings: AppSettings
  KottiRootDocument: KottiRootDocument

