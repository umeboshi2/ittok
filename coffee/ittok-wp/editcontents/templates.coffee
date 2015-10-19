tc = require 'teacup'
marked = require 'marked'

{ navbar_collapse_button
  dropdown_toggle
  frontdoor_url
  editor_url } = require '../templates/common'

{ workflow_dropdown } = require '../templates/editorbar'

# Main Templates must use teacup.
# The template must be a teacup.renderable, 
# and accept a layout model as an argument.

########################################
# Templates
########################################
button_icons =
  paste: 'fa-paste'
  copy: 'fa-copy'
  cut: 'fa-cut'
  rename_nodes: 'fa-pencil-square-o'
  delete_nodes: 'fa-remove'
  change_state: 'fa-bicycle'
  up: 'fa-arrow-up'
  down: 'fa-arrow-down'
  show: 'fa-eye'
  hide: 'fa-eye-slash'

popover_image = tc.renderable (url) ->
  tc.img src:url

ContentsViewTemplate = tc.renderable (doc) ->
  atts = doc.data.attributes
  relmeta = doc.data.relationships.meta
  lineage = relmeta.lineage.slice()
  lineage.reverse()
  tc.div '.document-view.content', ->
    tc.h1 atts.title
    tc.p '.lead', atts.description
    #tc.div tags
    # FIXME i18n
    tc.h2 'Contents'
    tc.div '.body', ->
      tc.div '#contents-path', ->
        [first, ..., last] = lineage
        #console.log "first and last", first, last
        for item in lineage
          tc.a '.btn.btn-default.btn-small', name:item.name,
          href:editor_url('contents', item.path), ->
            if item.id == first?.id
              tc.i '.fa.fa-home.fa-fw'
            if not (item.id == first?.id or item.id == last?.id)
              tc.i '.fa.fa-folder.fa-fw'
            if (item.id == last?.id and item.id != first?.id)
              tc.i '.fa.fa-folder-open-o.fa-fw'
            tc.text item.title
      # don't use a form, but use xhr post instead
      # <form action="${request.resource_url(context, '@@contents')}" method="post">
      #tc.div ->
      tc.form '#contents-form', ->
        # table only needed if length children
        if relmeta.children.length
          tclasses = "table.table-condensed.table-striped.table-hover"
          tc.table "#contents-table.#{tclasses}", ->
            tc.thead ->
              tc.tr ->
                tc.th ->
                  tc.input '#toggle-all', type:'checkbox',
                  title:'Select / deselect all'
                tc.th 'Title'
                tc.th 'Type'
                tc.th 'State'
                tc.th 'Visibility'
                tc.th 'Creation Date'
                tc.th 'Modification Date'
            tc.tbody ->
              for child in relmeta.children
                type_info = child.data.relationships.meta.type_info
                tc.tr "##{child.position}", ->
                  tc.td ->
                    tc.input name:'children', type:'checkbox',
                    value:child.data.id,
                    title:child.data.attributes.title
                  tc.td ->
                    tc.a href:editor_url('contents', child.path), ->
                      tc.text child.data.attributes.title
                    if type_info.name == 'Image'
                      imgtag = """<img src="#{type_info.image_span4_url}">"""
                      tc.br()
                      tc.img '.thumb', src:type_info.image_span1_url,
                      'data-content':imgtag,
                      title:child.data.attributes.title
                  tc.td type_info.title
                  tc.td ->
                    lstyle = 'list-style-type: none; padding: 0; margin: 0;'
                    tc.ul style:lstyle, ->
                      workflow_dropdown doc
                  tc.td ->
                    if child.meta.in_navigation
                      tc.i '.fa.fa-eye'
                      tc.span 'Visible'
                    else
                      tc.i '.fa.fa-eye-slash'
                      tc.span 'Hidden'
                  tc.td child.meta.creation_date
                  tc.td child.meta.modification_date
          tc.div ".btn-group", ->
            for btn in relmeta.contents_buttons
              tc.div ".action-button.#{btn.css_classes.join('.')}.btn-sm",
              #name:btn.name, type:'submit', ->
              name:btn.name, ->
                tc.i ".fa.#{button_icons[btn.name]}.fa-fw"
                tc.small ->
                  tc.text btn.title






module.exports =
  ContentsViewTemplate: ContentsViewTemplate


