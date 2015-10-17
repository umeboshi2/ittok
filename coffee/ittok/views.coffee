define (require, exports, module) ->
  Backbone = require 'backbone'
  Marionette = require 'marionette'


  NavTemplates = require 'templates/navbar'
  EditorBarTemplates = require 'templates/editorbar'
  LayoutTemplates = require 'templates/layout'
  MiscTemplates = require 'templates/misc'
  
  
  class MainPageLayout extends Backbone.Marionette.LayoutView
    template: LayoutTemplates.MainLayoutTemplate

  class BootstrapNavBarView extends Backbone.Marionette.LayoutView
    template: NavTemplates.nav_pt
    window.NavTemplates = NavTemplates
    regions:
      #navbarview: '#navbar-view'
      usermenu: '#user-menu'
      mainmenu: '#main-menu'

  class MainSearchFormView extends Backbone.Marionette.ItemView
    template: NavTemplates.nav_pt_search
    
  class EditBarView extends Backbone.Marionette.LayoutView
    template: EditorBarTemplates.editor_bar_pt
    
  class BreadCrumbView extends Backbone.Marionette.ItemView
    template: MiscTemplates.breadcrumbs
    
  class UserMenuView extends Backbone.Marionette.ItemView
    template: MiscTemplates.user_menu

  class MessageView extends Backbone.Marionette.ItemView
    template:MiscTemplates.message_box
    
  module.exports =
    MainPageLayout: MainPageLayout
    MainSearchFormView: MainSearchFormView
    EditBarView: EditBarView
    BootstrapNavBarView: BootstrapNavBarView
    #LoginView: LoginView
    BreadCrumbView: BreadCrumbView
    UserMenuView: UserMenuView
    MessageView: MessageView
    
