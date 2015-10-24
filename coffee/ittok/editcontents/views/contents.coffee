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
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'

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
    for child in @collection.models
      meta = child.get 'meta'
      path = remove_trailing_slashes meta.path
      model = ResourceChannel.request 'get-document', path
      response = model.destroy()
      callme = (response, path) ->
        response.node_path = path
        msg_signal = 'display-message'
        response.done =>
          MessageChannel.request(
            msg_signal, "#{response.node_path} deleted.", "success")
        response.fail =>
          MessageChannel.request(
            msg_signal, "DELETING #{response.node_path} FAILED.", "error")
      callme(response, path)
    @ui.cancel_button.click()

class ContentsChildView extends Backbone.Marionette.ItemView
  tagName: 'tr'
  template: AppTemplates.ContentsTableChildRow

  onShow: ->
    @$el.attr
      id: "#{@model.get('meta').position}"
      
class ContentsView extends Backbone.Marionette.CompositeView
  template: AppTemplates.ContentsViewTemplate
  childView: ContentsChildView
  childViewContainer: '#resource-children'
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
    view = new ConfirmDeleteView
      collection: children
    @_show_modal view
    
  handle_action_button: (event) ->
    name = event.currentTarget.getAttribute 'name'
    selected = @ui.contents_form.serializeArray()
    # FIXME paste should not need selected children
    if not selected.length
      msg = 'Select a child before pressing a button'
      MessageChannel.request 'display-message', msg, 'info'
      return
    selected_values = (parseInt c.value for c in selected)
    selected_models = []
    for id in selected_values
      selected_models.push @collection.get id
        
    if name in ['copy', 'cut', 'paste']
      cb = MainChannel.request 'main:app:kotti-clipboard'
      if name in ['copy', 'cut']
        cb[name] selected_models
        msg = "#{name} performed on #{selected_models.length} models"
        MessageChannel.request 'display-message', msg, 'success'
      else
        console.log "Handle paste"
    else if name == 'delete_nodes'
      #console.log 'show modal delete dialog'
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
        data = @model.get 'data'
        relmeta = data.relationships.meta
        this_path = remove_trailing_slashes relmeta.paths.this_path
        url = "#{this_path}/@@move-child-position"
        postdata =
          from: oldPosition
          to: newPosition
        response = make_json_post url, postdata
        response.done =>
          msg = "Moved from #{oldPosition} to #{newPosition} successfully!"
          level = 'info'
          MessageChannel.request 'display-message', msg, level

        response.fail =>
          #alert "Bad move!"
          MessageChannel.request 'display-message', "Bad Move!", 'danger'
          

    
module.exports = ContentsView
