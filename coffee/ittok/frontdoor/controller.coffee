define (require, exports, module) ->
  $ = require 'jquery'
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  marked = require 'marked'

  MainChannel = Backbone.Wreqr.radio.channel 'global'
  
  Views = require 'frontdoor/views'

  MainViews = require 'views'
  
  Util = require 'util'

  { MainController } = require 'controllers'
  
  class Controller extends MainController
    make_main_content: ->
      @_make_editbar()
      @_make_breadcrumbs()
      console.log "Make_Main_Content"
      view = new Views.FrontDoorMainView
        model: @root_doc
      @_show_content view

    _view_resource: -> 
      response = @root_doc.fetch()
      response.done =>
        @_make_editbar()
        @_make_breadcrumbs()
        view = new Views.FrontDoorMainView
          model: @root_doc
        @_show_content view
     
    view_resource: (resource) ->
      console.log "RESOURCE", resource
      @root_doc.id = "/#{resource}"
      @_view_resource()
      
    frontdoor: ->
      @root_doc.id = ""
      @_view_resource()
        
    start: ->
      #console.log 'controller.start called'
      @make_main_content()
      #console.log 'frontdoor started'

  module.exports = Controller
  
