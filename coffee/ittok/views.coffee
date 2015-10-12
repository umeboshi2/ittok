define (require, exports, module) ->
  Backbone = require 'backbone'
  Marionette = require 'marionette'


  Templates = require 'templates'

  class MainPageLayout extends Backbone.Marionette.LayoutView
    template: Templates.MainLayoutTemplate

  class BootstrapNavBarView extends Backbone.Marionette.LayoutView
    #template: Templates.BootstrapNavBarTemplate
    template: Templates.nav_pt
    regions:
      #navbarview: '#navbar-view'
      usermenu: '#user-menu'
      mainmenu: '#main-menu'

  class MainSearchFormView extends Backbone.Marionette.ItemView
    template: Templates.nav_pt_search
    
  class EditBarView extends Backbone.Marionette.LayoutView
    template: Templates.editor_bar_pt
    
      
  #class LoginView extends Backbone.Marionette.ItemView
  #  template: Templates.forms.login_form

  class UserMenuView extends Backbone.Marionette.ItemView
    template: Templates.user_menu
    
  module.exports =
    MainPageLayout: MainPageLayout
    MainSearchFormView: MainSearchFormView
    EditBarView: EditBarView
    BootstrapNavBarView: BootstrapNavBarView
    #LoginView: LoginView
    UserMenuView: UserMenuView
      
