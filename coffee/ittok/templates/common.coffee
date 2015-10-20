$ = require 'jquery'
_ = require 'underscore'
tc = require 'teacup'


# Main Templates must use teacup.
# The template must be a teacup.renderable, 
# and accept a layout model as an argument.

########################################
# Templates
########################################

frontdoor_url = (path) ->
  stripped_path = path.replace /\/$/, ""
  "#frontdoor/view#{stripped_path}"

editor_url = (action, path) ->
  #console.log "action, path", action, path
  rstripped_path = path.replace /\/$/, ""
  lstripped_path = rstripped_path.replace /^\//, ""
  #console.log "lstripped_path", lstripped_path
  "#editor/#{action}/#{lstripped_path}"

########################################
module.exports =
  frontdoor_url: frontdoor_url
  editor_url: editor_url

