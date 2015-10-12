define (require, exports, module) ->
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  ft = require 'furniture'
  

  FDTemplates = require 'frontdoor/templates'

  BaseSideBarView = ft.views.sidebar
    
  class FrontDoorMainView extends Backbone.Marionette.ItemView
    template: FDTemplates.frontdoor_main

  module.exports =
    FrontDoorMainView: FrontDoorMainView
