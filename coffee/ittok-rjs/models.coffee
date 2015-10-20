define (require, exports, module) ->
  $ = require 'jquery'
  _ = require 'underscore'
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  
  
  MainChannel = Backbone.Wreqr.radio.channel 'global'
  
    
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
      
  class AppSettings extends Backbone.Model
    id: 'ittok'

  class KottiRootDocument extends BaseKottiModel
    url: "@@json"

  class KottiDefaultViewSelector extends Backbone.Model
    

  app_settings = new AppSettings
  MainChannel.reqres.setHandler 'main:app:settings', ->
    app_settings
    
        
  #root_document = new KottiRootDocument
  #MainChannel.reqres.setHandler 'main:app:root-document', ->
  #  root_document

  MainChannel.reqres.setHandler 'main:app:get-document', (path) ->
    new BaseKottiModel
      id: path

  main_message_collection = new KottiMessages
  MainChannel.reqres.setHandler 'main:app:messages', ->
    main_message_collection
    
  module.exports =
    KottiMessage: KottiMessage
    AppSettings: AppSettings
    KottiRootDocument: KottiRootDocument
    
