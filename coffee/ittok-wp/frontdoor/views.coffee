Backbone = require 'backbone'
Marionette = require 'marionette'

FDTemplates = require 'frontdoor/templates'

tableDnD = require 'tablednd'

{ remove_trailing_slashes
  make_json_post } = require 'util'

MainChannel = Backbone.Wreqr.radio.channel 'global'

class FrontDoorMainView extends Backbone.Marionette.ItemView
  template: FDTemplates.DefaultViewTemplate

class FolderView extends Backbone.Marionette.ItemView
  template: FDTemplates.FolderViewTemplate

exports =
  FrontDoorMainView: FrontDoorMainView
  FolderView: FolderView

