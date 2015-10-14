define (require, exports, module) ->
  $ = require 'jquery'
  _ = require 'underscore'
  tc = require 'teacup'



  { dropdown_toggle
    frontdoor_url } = require 'templates/common'
  
  # Main Templates must use teacup.
  # The template must be a teacup.renderable, 
  # and accept a layout model as an argument.
  
  ########################################
  # Templates
  ########################################
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
              
  breadcrumbs = tc.renderable (doc) ->
    tc.ol '.breadcrumb', ->
      tc.small 'You are here:  '
      for item in doc.data.relationships.meta.breadcrumbs
        tc.li ->
          tc.a href:frontdoor_url(item.path), item.title
          
  ########################################
  module.exports =
    user_menu: user_menu
    breadcrumbs: breadcrumbs
