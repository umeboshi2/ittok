#
# Simple entry app
define (require, exports, module) ->
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  Wreqr = require 'backbone.wreqr'
  ft = require 'furniture'
  
  Controller = require 'frontdoor/controller'

  MainChannel = Backbone.Wreqr.radio.channel 'global'
  WikiChannel = Backbone.Wreqr.radio.channel 'sitetext'
  
  { BootStrapAppRouter } = ft.approuters.bootstrap

  class Router extends BootStrapAppRouter
    appRoutes:
      '': 'start'
      'frontdoor': 'start'
      
  MainChannel.reqres.setHandler 'applet:frontdoor:route', () ->
    console.log "frontdoor:route being handled"
    #page_collection = WikiChannel.reqres.request 'get-pages'
    #response = page_collection.fetch()
    #response.done =>
    appmodel = MainChannel.reqres.request 'main:app:appmodel'
    root_doc = MainChannel.reqres.request 'main:app:root-document'
    response = root_doc.fetch()
    response.done =>
      controller = new Controller MainChannel
      controller.root_doc = root_doc
      router = new Router
        controller: controller
      #console.log 'router created'
      window.controller = controller
      controller.start()
