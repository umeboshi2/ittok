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

  frontdoor_url = (path) ->
    stripped_path = path.replace /\/$/, ""
    "#frontdoor/view#{stripped_path}"
              
  ########################################
  module.exports =
    navbar_collapse_button: navbar_collapse_button
    dropdown_toggle: dropdown_toggle
    frontdoor_url: frontdoor_url
