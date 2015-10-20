$ = require 'jquery'
_ = require 'underscore'
tc = require 'teacup'



{ dropdown_toggle
  frontdoor_url } = require './common'

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

message_box = tc.renderable (msg) ->
  lvl = msg.level
  if lvl == 'error'
    lvl = 'danger'
  tc.div ".alert-dismissable.alert.alert-#{lvl}", ->
    tc.button '.close', type:'button', 'data-dismiss':'alert',
    'aria-hidden': true, ->
      tc.raw '&times;'
    tc.text msg.content

########################################
module.exports =
  user_menu: user_menu
  breadcrumbs: breadcrumbs
  message_box: message_box
