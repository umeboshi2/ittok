define (require, exports, module) ->
  Backbone = require 'backbone'
  Marionette = require 'marionette'


  Templates = require 'templates'

  class MainPageLayout extends Backbone.Marionette.LayoutView
    template: Templates.MainLayoutTemplate

  class BootstrapNavBarView extends Backbone.Marionette.LayoutView
    template: Templates.BootstrapNavBarTemplate
    regions:
      usermenu: '#user-menu'
      mainmenu: '#main-menu'
      
  #class LoginView extends Backbone.Marionette.ItemView
  #  template: Templates.forms.login_form

  class UserMenuView extends Backbone.Marionette.ItemView
    template: Templates.user_menu
    
  module.exports =
    MainPageLayout: MainPageLayout
    BootstrapNavBarView: BootstrapNavBarView
    #LoginView: LoginView
    UserMenuView: UserMenuView
      
