(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var AppModel, Backbone, BootstrapModalRegion, MainChannel, Marionette, Views, app, current_user_url, ft, handles, initialize_page, prepare_app, response, set_get_current_user_handler, user;
    Backbone = require('backbone');
    Marionette = require('marionette');
    ft = require('furniture');
    require('bootstrap');
    require('bootstrap-fileinput');
    require('json-editor');
    handles = ft.misc.mainhandles;
    Views = require('views');
    AppModel = require('appmodel');
    MainChannel = Backbone.Wreqr.radio.channel('global');
    BootstrapModalRegion = (function(superClass) {
      extend(BootstrapModalRegion, superClass);

      function BootstrapModalRegion() {
        return BootstrapModalRegion.__super__.constructor.apply(this, arguments);
      }

      BootstrapModalRegion.prototype.el = '#modal';

      BootstrapModalRegion.prototype.getEl = function(selector) {
        var $el;
        $el = $(selector);
        $el.attr('class', 'modal');
        return $el;
      };

      BootstrapModalRegion.prototype.show = function(view) {
        BootstrapModalRegion.__super__.show.call(this, view);
        this.$el.modal({
          backdrop: false
        });
        return this.$el.modal('show');
      };

      return BootstrapModalRegion;

    })(Backbone.Marionette.Region);
    initialize_page = function(app) {
      var appmodel, layout, mainview, regions;
      regions = MainChannel.reqres.request('main:app:regions');
      appmodel = MainChannel.reqres.request('main:app:appmodel');
      layout = new Views.MainPageLayout;
      layout.on('show', (function(_this) {
        return function() {
          var navbar, navbar_region;
          navbar = new Views.BootstrapNavBarView({
            model: appmodel
          });
          navbar_region = regions.get('navbar');
          return navbar_region.show(navbar);
        };
      })(this));
      mainview = regions.get('mainview');
      return mainview.show(layout);
    };
    prepare_app = function(app, appmodel) {
      var navbar, region_manager, regions;
      regions = appmodel.get('regions');
      if ('modal' in regions) {
        regions.modal = BootstrapModalRegion;
      }
      region_manager = new Backbone.Marionette.RegionManager;
      region_manager.addRegions(regions);
      navbar = region_manager.get('navbar');
      navbar.on('show', (function(_this) {
        return function() {
          return MainChannel.vent.trigger('appregion:navbar:displayed');
        };
      })(this));
      MainChannel.reqres.setHandler('main:app:appmodel', function() {
        return appmodel;
      });
      MainChannel.reqres.setHandler('main:app:object', function() {
        return app;
      });
      MainChannel.reqres.setHandler('main:app:regions', function() {
        return region_manager;
      });
      MainChannel.reqres.setHandler('main:app:get-region', function(region) {
        return region_manager.get(region);
      });
      return app.on('start', function() {
        var applet, frontdoor, i, len, ref, signal;
        frontdoor = appmodel.get('frontdoor_app');
        MainChannel.reqres.request("applet:" + frontdoor + ":route");
        ref = appmodel.get('applets');
        for (i = 0, len = ref.length; i < len; i++) {
          applet = ref[i];
          signal = "applet:" + applet.appname + ":route";
          MainChannel.reqres.request(signal);
        }
        MainChannel.reqres.request('mainpage:init', appmodel);
        if (!Backbone.history.started) {
          return Backbone.history.start();
        }
      });
    };
    MainChannel.reqres.setHandler('main:app:appmodel', function() {
      return AppModel;
    });
    set_get_current_user_handler = ft.models.base.set_get_current_user_handler;
    current_user_url = '/@@apiuserview';
    set_get_current_user_handler(MainChannel, current_user_url);
    MainChannel.reqres.setHandler('mainpage:init', (function(_this) {
      return function(appmodel) {
        var app;
        app = MainChannel.reqres.request('main:app:object');
        initialize_page(app);
        return MainChannel.vent.trigger('mainpage:displayed');
      };
    })(this));
    MainChannel.vent.on('appregion:navbar:displayed', function() {
      var user, usermenu, view;
      user = MainChannel.reqres.request('main:app:current-user');
      view = new Views.UserMenuView({
        model: user
      });
      usermenu = MainChannel.reqres.request('main:app:get-region', 'usermenu');
      return usermenu.show(view);
    });
    require('frontdoor/main');
    app = new Marionette.Application();
    window.App = app;
    user = MainChannel.reqres.request('main:app:current-user');
    response = user.fetch();
    response.done(function() {
      console.log('done done done, got user?', user);
      window.user = user;
      prepare_app(app, AppModel);
      return app.start();
    });
    return module.exports = app;
  });

}).call(this);

//# sourceMappingURL=application.js.map
