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

  handle_action_button_ugly: (event) ->
    window.ae = event
    name = event.currentTarget.getAttribute 'name'
    console.log "NAME", name
    window.checkboxes = @ui.checkboxes
    console.log "Serialize", @ui.contents_form.serializeArray()
    console.log "FIXME - implement action buttons"
    window.cform = @ui.contents_form
    if name == 'copy'
      url = "#{@model.id}/@@contents"
      values = []
      children = @ui.contents_form.serializeArray()
      for co in children
        values.push co.value
      data =
        'children': values
      data[name] = name
      console.log "DATA", data
      response = make_json_post url, data, 'POST'
      console.log "RESPONSE", response
      response.done =>
        console.log "somehting happened"
        
  handle_action_button: (event) ->
    #window.ae = event
    name = event.currentTarget.getAttribute 'name'
    console.log "NAME", name
    window.checkboxes = @ui.checkboxes
    console.log "Serialize", @ui.contents_form.serializeArray()
    console.log "FIXME - implement action buttons"
    window.cform = @ui.contents_form
    selected = @ui.contents_form.serializeArray()
    selected_values = (parseInt c.value for c in selected)
    console.log "selected_values", selected_values
    docdata = @model.get 'data'
    relmeta = docdata.relationships.meta
    children = docdata.relationships.meta.children
    
    selected_models = []
    for c in children
      if c.data.attributes.oid in selected_values
        selected_models.push c
    console.log "SELECTED_MODELS", selected_models
    #for child in children
    if name in ['copy', 'cut', 'paste']
      console.log "Clipboard operation #{name}"
      cb = MainChannel.request 'main:app:kotti-clipboard'
      if name in ['copy', 'cut']
        cb[name] selected_models
        msg = "#{name} performed on #{selected_models.length} models"
        MainChannel.request 'main:app:display-message', msg, 'success'
        
      
        
  onDomRefresh: ->
    @ui.thumbnails.popover
      html: true
      trigger: 'hover'

    @ui.contents_table.tableDnD
      onDrop: (table, row) =>
        rows = table.tBodies[0].rows
        # FIXME why do we do the parseInt?
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
