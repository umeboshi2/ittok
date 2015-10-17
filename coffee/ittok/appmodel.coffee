define (require, exports, module) ->
  $ = require 'jquery'
  jQuery = require 'jquery'
  _ = require 'underscore'
  Backbone = require 'backbone'

  class BaseAppModel extends Backbone.Model
    defaults:
      brand:
        name: 'Brand'
        url: '/'
      frontdoor_app: 'frontdoor'
      hasUser: false
      frontdoor_sidebar:
        [
          {
            name: 'Home'
            url: '/'
          }
        ]
      applets: []
      regions: {}
      routes: []
      
  
  
      
  appregions = 
    mainview: 'body'
    navbar: '#navbar-view-container'
    editbar: '#editor-bar-container'
    sidebar: '#sidebar'
    breadcrumbs: '#breadcrumbs'
    content: '#main-content'
    messages: '#messages'
    footer: '#footer'
    modal: '#modal'
    # this region is on navbar-view
    # depends on #navbar-view-container
    usermenu: '#user-menu'
    search: '#form-search-container'
  
  appmodel = new BaseAppModel
    hasUser: true
    brand:
      name: 'Kotti'
      url: '/'
    applets:
      [
        {
          appname: 'useradmin'
          name: 'Accounts'
          url: '#useradmin'
        }
      ]
    regions: appregions
  
  module.exports = appmodel
