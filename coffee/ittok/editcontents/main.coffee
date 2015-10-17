#
# Simple entry app
define (require, exports, module) ->
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  Wreqr = require 'backbone.wreqr'

  Util = require 'util'
  
  Controller = require 'editcontents/controller'

  MainChannel = Backbone.Wreqr.radio.channel 'global'
  
  class BootStrapAppRouter extends Backbone.Marionette.AppRouter
    onRoute: (name, path, args) ->
      #console.log "onRoute name: #{name}, path: #{path}, args: #{args}"
      Util.navbar_set_active path

  class Router extends BootStrapAppRouter
    appRoutes:
      'editor/contents': 'manage_root_contents'
      'editor/contents/*resource': 'manage_contents'
      
  MainChannel.reqres.setHandler 'applet:editcontents:route', () ->
    console.log "editcontents:route being handled"
    controller = new Controller MainChannel
    controller.root_doc = MainChannel.reqres.request 'main:app:current-document'
    router = new Router
      controller: controller
      
