Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

AppTemplates = require '../templates'

tableDnD = require 'tablednd'

require 'jquery-ui'
#require 'jquery-ui/widget'
#require 'jquery-ui/position'

{ remove_trailing_slashes
  make_json_post } = require 'apputil'

MainChannel = Backbone.Radio.channel 'global'

class NotImplementedModalView extends Backbone.Marionette.ItemView
  template: AppTemplates.NotImplementedModal
  
class SelectedChildView extends Backbone.Marionette.ItemView
  template: AppTemplates.SelectedChild
  
class ConfirmDeleteView extends Backbone.Marionette.CompositeView
  template: AppTemplates.ConfirmDeleteTemplate
  childView: SelectedChildView
  childViewContainer: '#selected-children'
  
  ui:
    confirm_button: '#confirm-delete-button'
    cancel_button: '#cancel-delete-button'
    
  events:
    'click @ui.confirm_button': 'delete_nodes'

  delete_nodes: =>
    window.deleteme = @collection
    console.log "Delete these nodes"
    for child in @collection.models
      path = remove_trailing_slashes child.get 'path'
      console.log "PATH", path
      model = MainChannel.request 'main:app:get-document', path
      response = model.destroy()
      callme = (response, path) ->
        response.node_path = path
        msg_signal = 'main:app:display-message'
        response.done =>
          MainChannel.request(
            msg_signal, "#{response.node_path} deleted.", "success")
        response.fail =>
          MainChannel.request(
            msg_signal, "DELETING #{response.node_path} FAILED.", "error")
      callme(response, path)
    #modal = MainChannel.request 'main:app:get-region', 'modal'
    #modal.empty()
    @ui.cancel_button.click()
        
class ContentsView extends Backbone.Marionette.ItemView
  template: AppTemplates.ContentsViewTemplate
  ui:
    toggle_all: '#toggle-all'
    contents_table: '#contents-table'
    contents_form: '#contents-form'
    checkboxes: 'input[type=checkbox]'
    child_checkboxes: 'input[type=checkbox][name="children"]'
    thumbnails: '.document-view.content img.thumb'
    action_buttons: '.action-button'


  events: ->
    'change @ui.toggle_all': 'toggle_all'
    'click .action-button': 'handle_action_button'


  toggle_all: ->
    @ui.checkboxes.prop 'checked', @ui.toggle_all[0].checked

  _show_modal: (view) ->
    modal_region = MainChannel.request 'main:app:get-region', 'modal'
    modal_region.show view
    

  handle_delete_action: (selected_models) ->
    children = new Backbone.Collection selected_models
    #model = new Backbone.Model selected_models
    window.selected_children = children
    view = new ConfirmDeleteView
      collection: children
    @_show_modal view
    
  handle_action_button: (event) ->
    #window.ae = event
    name = event.currentTarget.getAttribute 'name'
    #console.log "NAME", name
    selected = @ui.contents_form.serializeArray()
    # FIXME paste should not need selected children
    if not selected.length
      msg = 'Select a child before pressing a button'
      MainChannel.request 'main:app:display-message', msg, 'info'
      return
    selected_values = (parseInt c.value for c in selected)
    #console.log "selected_values", selected_values
    docdata = @model.get 'data'
    relmeta = docdata.relationships.meta
    children = docdata.relationships.meta.children
    
    selected_models = []
    for c in children
      if c.data.attributes.oid in selected_values
        selected_models.push c
    #console.log "SELECTED_MODELS", selected_models
    if name in ['copy', 'cut', 'paste']
      console.log "Clipboard operation #{name}"
      cb = MainChannel.request 'main:app:kotti-clipboard'
      if name in ['copy', 'cut']
        cb[name] selected_models
        msg = "#{name} performed on #{selected_models.length} models"
        MainChannel.request 'main:app:display-message', msg, 'success'
      else
        console.log "Handle paste"
    else if name == 'delete_nodes'
      console.log 'show modal delete dialog'
      @handle_delete_action selected_models
    else
      model = new Backbone.Model name:name
      view = new NotImplementedModalView
        model: model
      @_show_modal view
      
      
        
  onDomRefresh: ->
    @ui.thumbnails.popover
      html: true
      trigger: 'hover'

    @ui.contents_table.tableDnD
      onDrop: (table, row) =>
        rows = table.tBodies[0].rows
        oldPosition = parseInt row.id, 10
        newPosition = parseInt row.id, 10
        index = 0
        for row in rows
          if parseInt(row.id, 10) == oldPosition
            newPosition = index
            break
          index += 1
        #console.log "oldPosition #{oldPosition}, newPosition #{newPosition}"
        data = @model.get 'data'
        relmeta = data.relationships.meta
        this_path = remove_trailing_slashes relmeta.paths.this_path
        url = "#{this_path}/@@move-child-position"
        #console.log "url", url
        postdata =
          from: oldPosition
          to: newPosition
        response = make_json_post url, postdata
        response.done =>
          #console.log "Success"
          msg = "Moved from #{oldPosition} to #{newPosition} successfully!"
          level = 'info'
          MainChannel.request 'main:app:display-message', msg, level

        response.fail =>
          alert "Bad move!"


    
module.exports = ContentsView
