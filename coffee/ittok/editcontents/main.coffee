Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Util = require 'apputil'
BootStrapAppRouter = require 'bootstrap_router'

Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'



class Router extends BootStrapAppRouter
  appRoutes:
    'editor/contents': 'manage_root_contents'
    'editor/contents/*resource': 'manage_contents'
    'editor/edit/*resource': 'edit_node'
    'editor/aceedit': 'ace_edit_node'
    'editor/aceedit/*resource': 'ace_edit_node'
    
MainChannel.reply 'applet:editcontents:route', () ->
  console.log "editcontents:route being handled"
  controller = new Controller MainChannel
  controller.root_doc = MainChannel.request 'main:app:current-document'
  router = new Router
    controller: controller

