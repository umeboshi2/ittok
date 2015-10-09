define (require, exports, module) ->
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  #Wreqr = require 'backbone.wreqr'
  ft = require 'furniture'
  require 'bootstrap'
  require 'bootstrap-fileinput'

  require 'json-editor'
  
  handles = ft.misc.mainhandles

  Views = require 'views'
  AppModel = require 'appmodel'


  MainChannel = Backbone.Wreqr.radio.channel 'global'

  class BootstrapModalRegion extends Backbone.Marionette.Region
    el: '#modal'
        
    getEl: (selector) ->
      $el = $ selector
      $el.attr 'class', 'modal'
      #$el.attr 'class', 'modal fade'
      $el

    show: (view) ->
      super view
      @$el.modal
        backdrop: false
      @$el.modal 'show'
      
  initialize_page = (app) ->
    regions = MainChannel.reqres.request 'main:app:regions'
    appmodel = MainChannel.reqres.request 'main:app:appmodel'
    # create layout view
    layout = new Views.MainPageLayout
    # set the main layout view to create and show
    # the navbar when it is shown.  This assures us
    # that the $el is present in the DOM. 
    layout.on 'show', =>
      navbar = new Views.BootstrapNavBarView
        model: appmodel
      navbar_region = regions.get 'navbar'
      navbar_region.show navbar
    # Show the main layout
    mainview = regions.get 'mainview'
    mainview.show layout


    
  prepare_app = (app, appmodel) ->
    regions = appmodel.get 'regions'
    if 'modal' of regions
      regions.modal = BootstrapModalRegion

    region_manager = new Backbone.Marionette.RegionManager
    region_manager.addRegions regions

    navbar = region_manager.get 'navbar'
    navbar.on 'show', =>
        #console.log "we have users for this app....."
        # trigger the display message to create
        # the user menu on the navbar
        MainChannel.vent.trigger 'appregion:navbar:displayed'
        

    # set more main:app handlers
    MainChannel.reqres.setHandler 'main:app:appmodel', ->
      appmodel
    MainChannel.reqres.setHandler 'main:app:object', ->
      app
    MainChannel.reqres.setHandler 'main:app:regions', ->
      region_manager
    MainChannel.reqres.setHandler 'main:app:get-region', (region) ->
      region_manager.get region

    # Prepare what happens to the app when .start() is called.
    app.on 'start', ->
      # build routes first
      frontdoor = appmodel.get 'frontdoor_app'
      MainChannel.reqres.request "applet:#{frontdoor}:route"
      for applet in appmodel.get 'applets'
        signal = "applet:#{applet.appname}:route"
        #console.log "create signal #{signal}"
        MainChannel.reqres.request signal
      # build main page layout
      MainChannel.reqres.request 'mainpage:init', appmodel
      # start the approutes
      # the 'frontdoor_app' should handle the '' <blank>
      # route for the initial page.
      Backbone.history.start() unless Backbone.history.started
        
  ######################
  # start app setup
  
  MainChannel.reqres.setHandler 'main:app:appmodel', ->
    #console.log "setHandler main:app:appmodel"
    AppModel

  # set the handler to retrieve the current user from the server
  set_get_current_user_handler = ft.models.base.set_get_current_user_handler
  current_user_url = '/@@apiuserview'
  set_get_current_user_handler MainChannel, current_user_url

        
  MainChannel.reqres.setHandler 'mainpage:init', (appmodel) =>
    # get the app object
    app = MainChannel.reqres.request 'main:app:object'
    # initialize the main view
    initialize_page app
    # emit the main view is ready
    MainChannel.vent.trigger 'mainpage:displayed'

  MainChannel.vent.on 'appregion:navbar:displayed', ->
    user = MainChannel.reqres.request 'main:app:current-user'
    view = new Views.UserMenuView
      model: user
    usermenu = MainChannel.reqres.request 'main:app:get-region', 'usermenu'
    usermenu.show view

  # require applets
  # 
  require 'frontdoor/main'


  
  app = new Marionette.Application()
  # attach app to window
  window.App = app

  
  user = MainChannel.reqres.request 'main:app:current-user'
  #user = null
  response = user.fetch()
  response.done ->
    console.log 'done done done, got user?', user
    window.user = user
    prepare_app app, AppModel
    app.start()
  
  
  module.exports = app
  
    
