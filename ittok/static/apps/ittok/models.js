(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var $, AppSettings, Backbone, BaseKottiModel, BaseLocalStorageModel, KottiDefaultViewSelector, KottiRootDocument, MainChannel, _, app_settings, ft;
    $ = require('jquery');
    _ = require('underscore');
    Backbone = require('backbone');
    ft = require('furniture');
    MainChannel = Backbone.Wreqr.radio.channel('global');
    BaseLocalStorageModel = ft.models.localstorage;
    BaseKottiModel = (function(superClass) {
      extend(BaseKottiModel, superClass);

      function BaseKottiModel() {
        return BaseKottiModel.__super__.constructor.apply(this, arguments);
      }

      BaseKottiModel.prototype.url = function() {
        return this.id + "/@@json";
      };

      return BaseKottiModel;

    })(Backbone.Model);
    AppSettings = (function(superClass) {
      extend(AppSettings, superClass);

      function AppSettings() {
        return AppSettings.__super__.constructor.apply(this, arguments);
      }

      AppSettings.prototype.id = 'ittok';

      return AppSettings;

    })(Backbone.Model);
    KottiRootDocument = (function(superClass) {
      extend(KottiRootDocument, superClass);

      function KottiRootDocument() {
        return KottiRootDocument.__super__.constructor.apply(this, arguments);
      }

      KottiRootDocument.prototype.url = "/@@json";

      return KottiRootDocument;

    })(BaseKottiModel);
    KottiDefaultViewSelector = (function(superClass) {
      extend(KottiDefaultViewSelector, superClass);

      function KottiDefaultViewSelector() {
        return KottiDefaultViewSelector.__super__.constructor.apply(this, arguments);
      }

      return KottiDefaultViewSelector;

    })(Backbone.Model);
    app_settings = new AppSettings;
    MainChannel.reqres.setHandler('main:app:settings', function() {
      return app_settings;
    });
    MainChannel.reqres.setHandler('main:app:get-document', function(path) {
      return new BaseKottiModel({
        id: path
      });
    });
    return module.exports = {
      AppSettings: AppSettings,
      KottiRootDocument: KottiRootDocument
    };
  });

}).call(this);

//# sourceMappingURL=models.js.map
