define (require, exports, module) ->
  $ = require 'jquery'
  jQuery = require 'jquery'
  _ = require 'underscore'
  Backbone = require 'backbone'
  ft = require 'furniture'
  BaseAppModel = ft.models.base.BaseAppModel
  
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
    regions: ft.misc.appregions.user_appregions
  
  module.exports = appmodel
