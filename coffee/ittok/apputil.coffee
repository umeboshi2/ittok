$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'

scroll_top_fast = ()  ->
  $('html, body').animate {scrollTop: 0}, 'fast'

navigate_to_url = (url) ->
  if url.split('/')[0] == ''
    window.location = url
  else
    r = new Backbone.Router
    r.navigate url, trigger:true

capitalize = (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

handle_newlines = (str) ->
 str.replace(/(?:\r\n|\r|\n)/g, '<br />')

#https://github.com/goodeggs/teacup-camel-to-kebab
camel_to_kebab = (str) ->
  str.replace(/([A-Z])/g, ($1) -> "-#{$1.toLowerCase()}")

navbar_set_active = (path) ->
  path_top = path.split('/')[0]
  for li in $('#app-navbar li')
    liq = $ li
    liq.removeClass('active')
    if path_top == liq.attr('appname')
      liq.addClass('active')

make_json_post_settings = (url, data, type='POST') ->
  settings =
    type: type
    url: url
    data: JSON.stringify data
    accepts: 'application/json'
    contentType: 'application/json'
  return settings

make_json_post = (url, data, type='POST') ->
  settings = make_json_post_settings url, data, type
  $.ajax settings

remove_trailing_slashes = (path) ->
  path.replace /\/$/, ""

module.exports =
  scroll_top_fast: scroll_top_fast
  navigate_to_url: navigate_to_url
  capitalize: capitalize
  handle_newlines: handle_newlines
  camel_to_kebab: camel_to_kebab
  navbar_set_active: navbar_set_active
  make_json_post_settings: make_json_post_settings
  make_json_post: make_json_post
  remove_trailing_slashes: remove_trailing_slashes







