define (require, exports, module) ->
  Backbone = require 'backbone'
  Marionette = require 'marionette'

  FDTemplates = require 'frontdoor/templates'

  class FrontDoorMainView extends Backbone.Marionette.ItemView
    template: FDTemplates.MainContentTemplate
    

  module.exports =
    FrontDoorMainView: FrontDoorMainView
