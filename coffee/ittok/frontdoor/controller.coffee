define (require, exports, module) ->
  $ = require 'jquery'
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  marked = require 'marked'

  ft = require 'furniture'
  
  MainChannel = Backbone.Wreqr.radio.channel 'global'
  WikiChannel = Backbone.Wreqr.radio.channel 'wiki'
  
  Views = require 'frontdoor/views'


  Util = ft.util

  BaseController = ft.controllers.base.BaseController
  
  class Controller extends BaseController
    mainbus: MainChannel
      
    make_main_content: ->
      console.log "Make_Main_Content"


    start: ->
      #console.log 'controller.start called'
      @make_main_content()
      #console.log 'frontdoor started'

  module.exports = Controller
  
