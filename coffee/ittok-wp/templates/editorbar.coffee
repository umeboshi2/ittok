$ = require 'jquery'
_ = require 'underscore'
tc = require 'teacup'


{ navbar_collapse_button
  dropdown_toggle
  frontdoor_url
  editor_url } = require 'templates/common'



# Main Templates must use teacup.
# The template must be a teacup.renderable, 
# and accept a layout model as an argument.

########################################
# Templates
########################################
workflow_dropdown = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  wf = relmeta.workflow
  tc.li '.dropdown', ->
    if wf.current_state.current and relmeta.has_permission?.state_change
      dropdown_toggle ->
        tc.span ".state-#{wf.current_state.name}", ->
          tc.text wf.current_state.title
          tc.b '.caret'
      tc.ul '.dropdown-menu', ->
        for trans in wf.transitions
          tc.li ->
            tc.a href:"#workflow-change", ->
              tc.text "Make "
              tc.span wf.states[trans.to_state]['title']
  if wf.current_state.current and not relmeta.has_permission?.state_change
    tc.a ".state-#{wf.current_state.name}", ->
      tc.text wf.current_state.title

default_view_selector = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  tc.li '.divider'
  tc.li '.dropdown-header', role:'presentation', ->
    tc.text "Set default view"
  for v in relmeta.selectable_default_views
    attrs = {}
    if not v.is_current
      attrs.href = '@@@set-default-view'
    tc.li ->
      tc.a attrs, ->
        tc.text v.title
        if v.is_current
          tc.b '.glyphicon.glyphicon-ok.pull-right'


actions_dropdown = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  tc.li '.dropdown', ->
    dropdown_toggle ->
      tc.span "Actions"
      tc.b ".caret"
    tc.ul '.dropdown-menu', ->
      for link in relmeta.link_parent
        tc.li ->
          tc.a href:link.url, link.title
      default_view_selector doc


add_dropdown = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  factories = relmeta.content_type_factories
  tc.li '.dropdown', ->
    #tc.a '.dropdown-toggle', href:"#", 'data-toggle':'dropdown', ->
    dropdown_toggle ->
      tc.span 'Add'
      tc.b '.caret'
    tc.ul '.dropdown-menu', ->
      for factory in factories
        tc.li ->
          tc.a href:factory.url, factory.title
      if factories
        tc.li '.divider'
        tc.li ->
          # FIXME i18n
          tc.a href:relmeta.upload_url, 'Upload Content'

user_menu_dropdown = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  user = relmeta.current_user
  tc.li '.dropdown.pull-right', ->
    dropdown_toggle ->
      tc.text user.title
      tc.b '.caret'
    tc.ul '#user-dropdown.dropdown-menu', ->
      tc.li ->
        tc.a href:user.prefs_url, ->
          tc.i '.fa.fa-gears.fa-fw'
          # FIXME i18n
          tc.span "Preferences"
      if relmeta.has_permission.admin
        tc.li '.divider'
        tc.li '.dropdown-header', role:'presentation', ->
          # FIXME i18n
          tc.text "Site Setup"
        for link in relmeta.site_setup_links
          tc.li ->
            tc.a href:link.url, link.title
      tc.li ->
        # FIXME - fix logout href
        tc.a href:'/@@logout', ->
          tc.i '.fa.fa-sign-out.fa-fw'
          # FIXME i18n
          tc.span 'Logout'

editor_bar_pt_content = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  this_path = relmeta.paths.this_path
  tc.div '.container-fluid', ->
    tc.div '.navbar-header', ->
      navbar_collapse_button 'navbar-edit'
    tc.div '#navbar-edit.collapse.navbar-collapse', ->
      tc.ul '.nav.navbar-nav.navbar-left', ->
        if relmeta.has_permission.edit
          workflow_dropdown doc
        # FIXME, check another way for active
        isactive = ''
        if relmeta.request_url == relmeta.api_url
          isactive = '.active'
        tc.li ->
          href = frontdoor_url this_path
          tc.a href:href, "View"
        # FIXME: figure out disable_context_links
        for link in relmeta.edit_links
          tc.li ->
            href = editor_url link.name, this_path
            tc.a href:href, link.title
        if relmeta.has_permission.edit
          actions_dropdown doc
        if relmeta.has_permission.add
          tc.li '.divider-vertical'
          add_dropdown doc
      tc.ul '.nav.navbar-nav.navbar-right', ->
        liclass = '.pull-right'
        if relmeta.request_url == relmeta.navigate_url
          liclass = "#{liclass}.active"
        tc.li liclass, ->
          # FIXME i18n
          tc.a href:relmeta.navigate_url, "Navigate"
        user_menu_dropdown doc


editor_bar_pt = tc.renderable (doc) ->
  tc.nav '#editor-bar.navbar.navbar-default.navbar-static-top', ->
    editor_bar_pt_content doc

MainLayoutTemplate = tc.renderable () ->
  tc.div '#navbar-view-container'
  tc.div '#editor-bar-container'
  tc.div '.container', ->
    # edit/breadcrumbs.pt
    tc.div '#breadcrumbs'
    tc.div '.row', ->
      tc.div '#main-content.col-md-9'
      tc.div '#right-slot.col-md-3.right-column'
  tc.div '#footer'
  tc.div '#modal'

breadcrumbs = tc.renderable (doc) ->
  relmeta = doc.data.relationships.meta
  tc.ol '.breadcrumb', ->
    tc.small 'You are here:  '
    for item in relmeta.breadcrumbs
      tc.li ->
        tc.a href:item.url, item.title

########################################
exports =
  workflow_dropdown: workflow_dropdown
  editor_bar_pt: editor_bar_pt

