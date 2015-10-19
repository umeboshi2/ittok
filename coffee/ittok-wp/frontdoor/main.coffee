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
  #console.log "frontdoor:route being handled"
  controller = new Controller MainChannel
  controller.root_doc = MainChannel.reqres.request 'main:app:current-document'
  router = new Router
    controller: controller

