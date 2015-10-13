# modular template loading
define (require, exports, module) ->
  tc = require 'teacup'
  marked = require 'marked'

  # Main Templates must use teacup.
  # The template must be a teacup.renderable, 
  # and accept a layout model as an argument.

  ########################################
  # Templates
  ########################################
  frontdoor_main = tc.renderable (content) ->
    window.dcon = content
    tc.raw content.data.attributes.body
    #tc.div 'hello there'
  MainContentTemplate = tc.renderable (doc) ->
    atts = doc.data.attributes
    tc.article '.document-view.content', ->
      tc.h1 atts.title
      tc.p '.lead', atts.description
      tc.div '.body', ->
        tc.raw atts.body
        
              
  module.exports =
    frontdoor_main: frontdoor_main
    MainContentTemplate: MainContentTemplate
    
