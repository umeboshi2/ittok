define (require, exports, module) ->
  $ = require 'jquery'
  jQuery = require 'jquery'
  _ = require 'underscore'
  Backbone = require 'backbone'
  ft = require 'furniture'
  BaseAppModel = ft.models.base.BaseAppModel
  
      
  appregions = 
    mainview: 'body'
    navbar: '#navbar-view-container'
    editbar: '#editor-bar-container'
    sidebar: '#sidebar'
    content: '#main-content'
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
