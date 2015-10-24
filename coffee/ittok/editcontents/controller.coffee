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
  _get_doc_and_render_view: (viewclass) ->
    response = @root_doc.fetch()
    response.done =>
      @_make_editbar()
      @_make_breadcrumbs()
      view = new viewclass
        model: @root_doc
      @_show_content view
      
  manage_contents: (resource) ->
    @_set_resource resource
    @_get_doc_and_render_view Views.ContentsView

  edit_node: (resource) ->
    console.log "EDIT RESOURCE", resource
    @_set_resource resource
    @_get_doc_and_render_view Views.EditorView

  ace_edit_node: (resource) ->
    console.log "ACE EDIT RESOURCE", resource
    @_set_resource resource
    @_get_doc_and_render_view Views.AceEditorView

    
module.exports = Controller

