(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var $, Backbone, BaseController, Controller, MainChannel, Marionette, Util, Views, WikiChannel, ft, marked;
    $ = require('jquery');
    Backbone = require('backbone');
    Marionette = require('marionette');
    marked = require('marked');
    ft = require('furniture');
    MainChannel = Backbone.Wreqr.radio.channel('global');
    WikiChannel = Backbone.Wreqr.radio.channel('wiki');
    Views = require('frontdoor/views');
    Util = ft.util;
    BaseController = ft.controllers.base.BaseController;
    Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.mainbus = MainChannel;

      Controller.prototype.make_main_content = function() {
        return console.log("Make_Main_Content");
      };

      Controller.prototype.start = function() {
        return this.make_main_content();
      };

      return Controller;

    })(BaseController);
    return module.exports = Controller;
  });

}).call(this);

//# sourceMappingURL=controller.js.map
