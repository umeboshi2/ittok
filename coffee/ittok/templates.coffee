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
  main_navbar_div = tc.renderable () ->
    tc.div "#main-navbar.navbar.navbar-default.navbar-fixed-top",
    role:'navigation'

  MainLayoutTemplate = tc.renderable () ->
    main_navbar_div()
    tc.div '.container-fluid', ->
      tc.div '.row', ->
        tc.div '#main-content.col-md-12'
    tc.div '#footer'
    tc.div '#modal'

  # This belongs in navbar layout view
  navbar_brand_div = tc.renderable (name, url) ->
    tc.div '#navbar-brand.navbar-header', ->
      tc.button '.navbar-toggle', type:'button', 'data-toggle': 'collapse',
      'data-target': '.navbar-collapse', ->
        tc.span '.sr-only', 'Toggle Navigation'
        tc.span '.icon-bar'
        tc.span '.icon-bar'
        tc.span '.icon-bar'
      tc.a '.navbar-brand', href:url, name

  navbar_items_div = tc.renderable (items) ->
    tc.div '.navbar-collapse.collapse', ->
      tc.ul '#app-navbar.nav.navbar-nav', ->
        for item in items
          attrs = {}
          if item?.appname
            attrs.appname = item.appname
          tc.li attrs, ->
            tc.a href:item.url, item.name
      tc.ul '#main-menu.nav.navbar-nav.navbar-left'
      tc.ul '#user-menu.nav.navbar-nav.navbar-right'

  BootstrapNavBarTemplate = tc.renderable (model) ->
    window.foomodel = model
    navbar_brand_div model.brand.name, model.brand.url
    #navbar_items_div model.items
    navbar_items_div model.applets
    
  user_menu = tc.renderable (user) ->
    tc.ul '#user-menu.ctx-menu.nav.navbar-nav', ->
      tc.li '.dropdown', ->
        tc.a '.dropdown-toggle', 'data-toggle':'dropdown', ->
          if 'title' of user
            tc.text user.title
          else
            tc.text "Guest"
        tc.ul '.dropdown-menu', ->
          if 'title' of user
            tc.li ->
              tc.a href:"/", 'MainPage'
            tc.li ->
              tc.a href:"/logout", "Logout"
          else
            tc.li ->
              tc.a href:'/login', 'Login'
              
  ########################################
  module.exports =
    main_navbar_div: main_navbar_div
    MainLayoutTemplate: MainLayoutTemplate
    BootstrapNavBarTemplate: BootstrapNavBarTemplate
    user_menu: user_menu
    
