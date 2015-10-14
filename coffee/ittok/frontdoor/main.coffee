#
# Simple entry app
define (require, exports, module) ->
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  Wreqr = require 'backbone.wreqr'

  Util = require 'util'
  
  Controller = require 'frontdoor/controller'

  MainChannel = Backbone.Wreqr.radio.channel 'global'
  
  class BootStrapAppRouter extends Backbone.Marionette.AppRouter
    onRoute: (name, path, args) ->
      #console.log "onRoute name: #{name}, path: #{path}, args: #{args}"
      Util.navbar_set_active path

  class Router extends BootStrapAppRouter
    appRoutes:
      '': 'start'
      'frontdoor': 'frontdoor'
      'frontdoor/view': 'frontdoor'
      'frontdoor/view/*resource': 'view_resource'
      
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
