define (require, exports, module) ->
  $ = require 'jquery'
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  marked = require 'marked'

  MainChannel = Backbone.Wreqr.radio.channel 'global'
  
  Views = require 'frontdoor/views'

  MainViews = require 'views'
  
  Util = require 'util'

  class BaseController extends Backbone.Marionette.Object
    init_page: () ->
      # do nothing
    scroll_top: Util.scroll_top_fast
    navigate_to_url: Util.navigate_to_url
    navbar_set_active: Util.navbar_set_active
  
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
        view = new MainViews.EditBarView
          model: @root_doc
        editbar.show view

    _make_breadcrumbs: ->
      data = @root_doc.get 'data'
      breadcrumbs = data.relationships.meta.breadcrumbs
      bc = @_get_region 'breadcrumbs'
      if breadcrumbs.length > 1
        view = new MainViews.BreadCrumbView
          model: @root_doc
        bc.show view
      else
        bc.empty()
        
      
      
    make_main_content: ->
      @_make_editbar()
      @_make_breadcrumbs()
      console.log "Make_Main_Content"
      view = new Views.FrontDoorMainView
        model: @root_doc
      @_show_content view

    view_resource: (resource) ->
      @root_doc.id = "/#{resource}"
      response = @root_doc.fetch()
      response.done =>
        view = new Views.FrontDoorMainView
          model: @root_doc
        @_show_content view
        @_make_breadcrumbs()

    frontdoor: ->
      @root_doc.id = ""
      response = @root_doc.fetch()
      response.done =>
        view = new Views.FrontDoorMainView
          model: @root_doc
        @_show_content view
        @_make_breadcrumbs()
        
    start: ->
      #console.log 'controller.start called'
      @make_main_content()
      #console.log 'frontdoor started'

  module.exports = Controller
  
