define (require, exports, module) ->
  $ = require 'jquery'
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  marked = require 'marked'

  MainChannel = Backbone.Wreqr.radio.channel 'global'
  
  Views = require 'editcontents/views'

  MainViews = require 'views'
  
  Util = require 'util'

  { MainController } = require 'controllers'
  
  class Controller extends MainController
    _set_resource: (resource) ->
      @root_doc.id = "/#{resource}"
            
    _manage_contents: ->
      response = @root_doc.fetch()
      response.done =>
        @_make_editbar()
        @_make_breadcrumbs()
        view = new Views.ContentsView
          model: @root_doc
        @_show_content view
        
    manage_contents: (resource) ->
      #console.log "Manage contents of", resource
      if resource == null
        return @manage_root_contents()
      @_set_resource resource
      @_manage_contents()
      
    manage_root_contents: ->
      #console.log "Manage_Root_Contents"
      @root_doc.id = ""
      @_manage_contents()
      
  module.exports = Controller
  
