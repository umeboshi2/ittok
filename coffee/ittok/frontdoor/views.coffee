Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

FDTemplates = require './templates'

tableDnD = require 'tablednd'

{ remove_trailing_slashes
  make_json_post } = require 'apputil'

MainChannel = Backbone.Radio.channel 'global'

class FrontDoorMainView extends Backbone.Marionette.ItemView
  template: FDTemplates.DefaultViewTemplate

class FolderView extends Backbone.Marionette.ItemView
  template: FDTemplates.FolderViewTemplate

module.exports =
  FrontDoorMainView: FrontDoorMainView
  FolderView: FolderView

