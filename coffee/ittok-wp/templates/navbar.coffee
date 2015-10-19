$ = require 'jquery'
_ = require 'underscore'
tc = require 'teacup'

{ navbar_collapse_button
  dropdown_toggle
  frontdoor_url } = require './common'


# Main Templates must use teacup.
# The template must be a teacup.renderable, 
# and accept a layout model as an argument.

########################################
# Templates
########################################
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
      tc.a '.navbar-brand', href:'#frontdoor', relmeta.site_title
    tc.div '#navbar-view-collapse.collapse.navbar-collapse', ->
      tc.ul '.nav.navbar-nav', ->
        for item in relmeta.navitems
          isactive = ""
          if item.inside
            isactive = ".active"
          tc.li isactive, ->
            tc.a href:frontdoor_url(item.path),
            title:item.description, item.title
      tc.ul '#user-menu.nav.navbar-nav.navbar-right'
      tc.div '#form-search-container'

nav_pt = tc.renderable (doc) ->
  tc.nav '#navbar-view.navbar.navbar-static-top.navbar-inverse',
  xmlns:'http://www.w3.org/1999/xhtml', 'xml:lang':'en',
  role:'navigation', ->
    nav_pt_content doc

########################################
module.exports =
  nav_pt_search: nav_pt_search
  nav_pt: nav_pt
