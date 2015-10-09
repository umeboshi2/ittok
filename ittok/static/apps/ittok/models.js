(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var $, AppSettings, Backbone, BaseLocalStorageModel, MainChannel, _, app_settings, ft;
    $ = require('jquery');
    _ = require('underscore');
    Backbone = require('backbone');
    ft = require('furniture');
    MainChannel = Backbone.Wreqr.radio.channel('global');
    BaseLocalStorageModel = ft.models.localstorage;
    AppSettings = (function(superClass) {
      extend(AppSettings, superClass);

      function AppSettings() {
        return AppSettings.__super__.constructor.apply(this, arguments);
      }

      AppSettings.prototype.id = 'ittok';

      return AppSettings;

    })(Backbone.Model);
    app_settings = new AppSettings;
    MainChannel.reqres.setHandler('main:app:settings', function() {
      return app_settings;
    });
    return module.exports = {
      AppSettings: AppSettings
    };
  });

}).call(this);

//# sourceMappingURL=models.js.map
