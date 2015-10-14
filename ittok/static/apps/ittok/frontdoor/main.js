(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var Backbone, BootStrapAppRouter, Controller, MainChannel, Marionette, Router, Util, Wreqr;
    Backbone = require('backbone');
    Marionette = require('marionette');
    Wreqr = require('backbone.wreqr');
    Util = require('util');
    Controller = require('frontdoor/controller');
    MainChannel = Backbone.Wreqr.radio.channel('global');
    BootStrapAppRouter = (function(superClass) {
      extend(BootStrapAppRouter, superClass);

      function BootStrapAppRouter() {
        return BootStrapAppRouter.__super__.constructor.apply(this, arguments);
      }

      BootStrapAppRouter.prototype.onRoute = function(name, path, args) {
        return Util.navbar_set_active(path);
      };

      return BootStrapAppRouter;

    })(Backbone.Marionette.AppRouter);
    Router = (function(superClass) {
      extend(Router, superClass);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.appRoutes = {
        '': 'start',
        'frontdoor': 'frontdoor',
        'frontdoor/view': 'frontdoor',
        'frontdoor/view/*resource': 'view_resource'
      };

      return Router;

    })(BootStrapAppRouter);
    return MainChannel.reqres.setHandler('applet:frontdoor:route', function() {
      var appmodel, response, root_doc;
      console.log("frontdoor:route being handled");
      appmodel = MainChannel.reqres.request('main:app:appmodel');
      root_doc = MainChannel.reqres.request('main:app:root-document');
      response = root_doc.fetch();
      return response.done((function(_this) {
        return function() {
          var controller, router;
          controller = new Controller(MainChannel);
          controller.root_doc = root_doc;
          router = new Router({
            controller: controller
          });
          window.controller = controller;
          return controller.start();
        };
      })(this));
    });
  });

}).call(this);

//# sourceMappingURL=main.js.map
