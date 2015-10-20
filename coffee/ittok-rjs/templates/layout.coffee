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
  MainLayoutTemplate = tc.renderable () ->
    tc.div '#navbar-view-container'
    tc.div '#editor-bar-container'
    tc.div '.container', ->
      # edit/breadcrumbs.pt
      tc.div '#breadcrumbs'
      tc.div '.row', ->
        tc.div 'col-md-12', ->
          tc.div '#messages'
        tc.div '#main-content.col-md-9'
        tc.div '#right-slot.col-md-3.right-column'
    tc.div '#footer'
    tc.div '#modal'

  MainContentTemplate = tc.renderable (doc) ->
    atts = doc.data.attributes
    tc.article '.document-view.content', ->
      tc.h1 atts.title
      tc.p '.lead', atts.description
      tc.div '.body', ->
        tc.raw atts.body
        
  ########################################
  module.exports =
    MainLayoutTemplate: MainLayoutTemplate
    MainContentTemplate: MainContentTemplate
    
