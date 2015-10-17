define (require, exports, module) ->
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

  class ContentsView extends Backbone.Marionette.ItemView
    template: FDTemplates.ContentsViewTemplate
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

    handle_action_button: (event) ->
      window.ae = event
      name = event.currentTarget.getAttribute 'name'
      console.log "NAME", name
      window.checkboxes = @ui.checkboxes
      console.log "Serialize", @ui.contents_form.serialize()
      console.log "FIXME - implement action buttons"
      
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
            MainChannel.reqres.request 'main:app:display-message', msg, level
            
          response.fail =>
            alert "Bad move!"
            
          
  class EditorView extends Backbone.Marionette.ItemView
    template: FDTemplates.ContentsViewTemplate
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
      
            
  module.exports =
    FrontDoorMainView: FrontDoorMainView
    FolderView: FolderView
    ContentsView: ContentsView
    EditorView: EditorView
    
