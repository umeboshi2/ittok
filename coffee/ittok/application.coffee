Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
require 'radio-shim'

require 'bootstrap'

Models = require './models'
Views = require './views'
AppModel = require './appmodel'
require './collections'
require 'bootstrap-fileinput-css'
require 'bootstrap-fileinput-js'

#require 'vie'
require 'frontdoor/main'
require 'editcontents/main'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'

Backbone.Radio.DEBUG = true

# FIXME
# sync should probably be overridden in model/collection
# instead of globally
# also, I could never get the rest view to respond to
# this accept header and decided to use "@@json" instead.
# 
#bbsync = Backbone.sync
#Backbone.sync = (method, model, options) ->
#  options.headers =
#    Accept: 'application/vnd.api+json'
#  bbsync method, model, options


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

initialize_page = (app, root_doc) ->
  regions = MainChannel.request 'main:app:regions'
  appmodel = MainChannel.request 'main:app:appmodel'
  # create layout view
  layout = new Views.MainPageLayout
  # set the main layout view to create and show
  # the navbar when it is shown.  This assures us
  # that the $el is present in the DOM. 
  layout.on 'show', =>
    navbar = new Views.BootstrapNavBarView
      model: root_doc
    navbar_region = regions.get 'navbar'
    navbar_region.show navbar
    messages = new Views.MessagesView
      collection: MessageChannel.request 'messages'
    messages_region = regions.get 'messages'
    messages_region.show messages
    
  # Show the main layout
  mainview = regions.get 'mainview'
  mainview.show layout



prepare_app = (app, appmodel, root_doc) ->
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
      MainChannel.trigger 'appregion:navbar:displayed'

  # set more main:app handlers
  MainChannel.reply 'main:app:object', ->
    app
  MainChannel.reply 'main:app:regions', ->
    region_manager
  MainChannel.reply 'main:app:get-region', (region) ->
    region_manager.get region

  # Prepare what happens to the app when .start() is called.
  app.on 'start', ->
    # build routes first
    frontdoor = appmodel.get 'frontdoor_app'
    MainChannel.request "applet:#{frontdoor}:route"
    for applet in appmodel.get 'applets'
      signal = "applet:#{applet.appname}:route"
      #console.log "create signal #{signal}"
      MainChannel.request signal
    # build main page layout
    MainChannel.request 'mainpage:init', appmodel, root_doc
    # start the approutes
    # the 'frontdoor_app' should handle the '' <blank>
    # route for the initial page.
    Backbone.history.start() unless Backbone.history.started


######################
# start app setup

MainChannel.reply 'main:app:appmodel', ->
  #console.log "setHandler main:app:appmodel"
  AppModel

MainChannel.reply 'mainpage:init', (appmodel, root_doc) =>
  # get the app object
  app = MainChannel.request 'main:app:object'
  # initialize the main view
  initialize_page app, root_doc
  # emit the main view is ready
  MainChannel.trigger 'mainpage:displayed'

MainChannel.on 'appregion:navbar:displayed', ->
  view = new Views.MainSearchFormView
    model: ResourceChannel.request 'current-document'
  search = MainChannel.request 'main:app:get-region', 'search'
  search.show view



app = new Marionette.Application()
# DEBUG attach app to window
window.App = app

here = location.pathname
#console.log "Here we are", here
if here == '/'
  here = ''
current_doc = ResourceChannel.request 'get-document', here
ResourceChannel.reply 'current-document', ->
  current_doc
# DEBUG  
window.current_doc = current_doc
response = current_doc.fetch()
response.done ->
  console.log "AppModel", AppModel
  prepare_app app, AppModel, current_doc
  app.start()


module.exports = app


