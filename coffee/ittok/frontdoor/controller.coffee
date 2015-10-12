define (require, exports, module) ->
  $ = require 'jquery'
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  marked = require 'marked'

  ft = require 'furniture'
  
  MainChannel = Backbone.Wreqr.radio.channel 'global'
  
  Views = require 'frontdoor/views'

  { EditBarView } = require 'views'
  
  Util = ft.util

  BaseController = ft.controllers.base.BaseController
  
  class Controller extends BaseController
    mainbus: MainChannel
    _get_region: (region) ->
      MainChannel.reqres.request 'main:app:get-region', region
      
    _show_content: (view) ->
      content = @_get_region 'content'
      content.show view

    _make_editbar: ->
      data = @root_doc.get 'data'
      user = data.relationships.meta.current_user
      console.log "_make_editbar", user
      # should have better way to check user?
      if user and 'title' of user
        editbar = @_get_region 'editbar'
        window.editbar = editbar
        view = new EditBarView
          model: @root_doc
        editbar.show view
      
    make_main_content: ->
      @_make_editbar()
      console.log "Make_Main_Content"
      view = new Views.FrontDoorMainView
        model: @root_doc
      @_show_content view
      
    start: ->
      console.log 'controller.start called'
      @make_main_content()
      #console.log 'frontdoor started'

  module.exports = Controller
  
