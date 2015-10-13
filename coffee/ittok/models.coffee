define (require, exports, module) ->
  $ = require 'jquery'
  _ = require 'underscore'
  Backbone = require 'backbone'
  ft = require 'furniture'
  
  MainChannel = Backbone.Wreqr.radio.channel 'global'
  
  BaseLocalStorageModel = ft.models.localstorage
    
  ########################################
  # Models
  ########################################

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
      
  module.exports =
    AppSettings: AppSettings
    KottiRootDocument: KottiRootDocument
    
