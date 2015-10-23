$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
marked = require 'marked'


Util = require 'apputil'
MainViews = require '../views'
{ MainController } = require '../controllers'

Views = require './views'

MainChannel = Backbone.Radio.channel 'global'



require.ensure [
  "hallo/src/hallo"
  "hallo/src/widgets/dropdownbutton"
  "hallo/src/widgets/button"
  "hallo/src/toolbar/contextual"
  "hallo/src/plugins/halloformat"
  "hallo/src/plugins/headings"
  "hallo/src/plugins/justify"
  "hallo/src/plugins/link"
  "hallo/src/plugins/lists"
  "hallo/src/plugins/reundo"
  "hallo/src/plugins/image_insert_edit"
  "hallo/src/plugins/image"
  "hallo/src/plugins/image/current"
  "hallo/src/plugins/block"
  "hallo/src/plugins/blacklist"], (require) ->
    EditView = Views.EditorView
    return EditView
    


class Controller extends MainController
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

  _edit_node: ->
    response = @root_doc.fetch()
    response.done =>
      console.log "Root_Doc", @root_doc
      @_make_editbar()
      @_make_breadcrumbs()
      view = new Views.EditorView
        model: @root_doc
      @_show_content view
      window.eview = view
      
  edit_node: (resource) ->
    console.log "EDIT RESOURCE", resource
    @_set_resource resource
    @_edit_node()

  _ace_edit_node: ->
    response = @root_doc.fetch()
    response.done =>
      console.log "Root_Doc", @root_doc
      @_make_editbar()
      @_make_breadcrumbs()
      view = new Views.AceEditorView
        model: @root_doc
      @_show_content view
      window.aceview = view
      
  ace_edit_node: (resource) ->
    console.log "ACE EDIT RESOURCE", resource
    @_set_resource resource
    @_ace_edit_node()
    
module.exports = Controller

