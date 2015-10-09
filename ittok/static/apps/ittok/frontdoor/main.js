(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var Backbone, BootStrapAppRouter, Controller, MainChannel, Marionette, Router, WikiChannel, Wreqr, ft;
    Backbone = require('backbone');
    Marionette = require('marionette');
    Wreqr = require('backbone.wreqr');
    ft = require('furniture');
    Controller = require('frontdoor/controller');
    MainChannel = Backbone.Wreqr.radio.channel('global');
    WikiChannel = Backbone.Wreqr.radio.channel('sitetext');
    BootStrapAppRouter = ft.approuters.bootstrap.BootStrapAppRouter;
    Router = (function(superClass) {
      extend(Router, superClass);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.appRoutes = {
        '': 'start',
        'frontdoor': 'start'
      };

      return Router;

    })(BootStrapAppRouter);
    return MainChannel.reqres.setHandler('applet:frontdoor:route', function() {
      var appmodel, controller, router, sidebar_data;
      appmodel = MainChannel.reqres.request('main:app:appmodel');
      sidebar_data = new Backbone.Model({
        entries: appmodel.get('frontdoor_sidebar')
      });
      controller = new Controller(MainChannel);
      controller.sidebar_model = sidebar_data;
      return router = new Router({
        controller: controller
      });
    });
  });

}).call(this);

//# sourceMappingURL=main.js.map
