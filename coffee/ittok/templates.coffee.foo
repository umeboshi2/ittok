define (require, exports, module) ->
  $ = require 'jquery'
  _ = require 'underscore'
  tc = require 'teacup'

  
  # Main Templates must use teacup.
  # The template must be a teacup.renderable, 
  # and accept a layout model as an argument.
  
  ########################################
  # Templates
  ########################################
  navbar_collapse_button  = tc.renderable (target) ->
    tc.button '.navbar-toggle', type:'button', 'data-toggle':'collapse',
    'data-target': "##{target}", ->
        tc.span '.sr-only', 'Toggle Navigation'
        tc.span '.icon-bar'
        tc.span '.icon-bar'
        tc.span '.icon-bar'
        
  dropdown_toggle = tc.component (selector, attrs, renderContents) ->
    tc.a "#{selector}.dropdown-toggle", href:attrs.href,
    'data-toggle':'dropdown', renderContents
    
  nav_pt_search = tc.renderable (doc) ->
    relmeta = doc.data.relationships.meta
    tc.form '#form-search.navbar-form.navbar-right', role:'search',
    method:'post', action:"#{relmeta.root_url}@@search-results", ->
      tc.div '.form-group', ->
        # FIXME search input placeholder needs to come from server
        tc.input '.form-control', name:'search-term', type:'search',
        placeholder:'Search...'
      tc.button '.btn.btn-default', type:'submit', name:'search-submit',
      value:'search', style:'display: none;', ->
        tc.raw '&#8594'
    
  nav_pt_content = tc.renderable (doc) ->
    relmeta = doc.data.relationships.meta
    tc.div '.container-fluid', ->
      tc.div '.navbar-header', ->
        navbar_collapse_button 'navbar-view-collapse'
        tc.a '.navbar-brand', href:relmeta.application_url, relmeta.site_title
      tc.div '#navbar-view-collapse.collapse.navbar-collapse', ->
        tc.ul '.nav.navbar-nav', ->
          for item in relmeta.navitems
            isactive = ""
            if item.inside
              isactive = ".active"
            tc.li isactive, ->
              tc.a href:item.url, title:item.description, item.title
        tc.ul '#user-menu.nav.navbar-nav.navbar-right'
        tc.div '#form-search-container'

  nav_pt = tc.renderable (doc) ->
    tc.nav '#navbar-view.navbar.navbar-static-top.navbar-inverse',
    xmlns:'http://www.w3.org/1999/xhtml', 'xml:lang':'en',
    role:'navigation', ->
      nav_pt_content doc

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
    tc.div '.container-fluid', ->
      tc.div '.navbar-header', ->
        navbar_collapse_button 'navbar-edit'
      tc.div '#navbar-edit.collapse.navbar-collapse', ->
        tc.ul '.nav.navbar-nav.navbar-left', ->
          if relmeta.has_permission.edit
            workflow_dropdown doc
          isactive = ''
          if relmeta.request_url == relmeta.api_url
            isactive = '.active'
          tc.li ->
            tc.a href:relmeta.api_url, "View"
          # FIXME: figure out disable_context_links
          for link in relmeta.edit_links
            tc.li ->
              tc.a href:link.url, link.title
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

  user_menu = tc.renderable (doc) ->
    user = doc.data.relationships.meta.current_user
    tc.ul '#user-menu.ctx-menu.nav.navbar-nav', ->
      tc.li '.dropdown', ->
        tc.a '.dropdown-toggle', 'data-toggle':'dropdown', ->
          if user and 'title' of user
            tc.text user.title
          else
            tc.text "Guest"
        tc.ul '.dropdown-menu', ->
          if user 
            tc.li ->
              tc.a href:"/", 'MainPage'
            tc.li ->
              tc.a href:"/logout", "Logout"
          else
            tc.li ->
              tc.a href:'/login', 'Login'
              
  ########################################
  module.exports =
    nav_pt_search: nav_pt_search
    nav_pt: nav_pt
    editor_bar_pt: editor_bar_pt
    MainLayoutTemplate: MainLayoutTemplate
    user_menu: user_menu
    
