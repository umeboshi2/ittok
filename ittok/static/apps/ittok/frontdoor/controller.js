(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var $, Backbone, Controller, MainChannel, MainController, MainViews, Marionette, Util, Views, marked;
    $ = require('jquery');
    Backbone = require('backbone');
    Marionette = require('marionette');
    marked = require('marked');
    MainChannel = Backbone.Wreqr.radio.channel('global');
    Views = require('frontdoor/views');
    MainViews = require('views');
    Util = require('util');
    MainController = require('controllers').MainController;
    Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.make_main_content = function() {
        var view;
        this._make_editbar();
        this._make_breadcrumbs();
        view = new Views.FrontDoorMainView({
          model: this.root_doc
        });
        return this._show_content(view);
      };

      Controller.prototype._set_resource = function(resource) {
        return this.root_doc.id = "/" + resource;
      };

      Controller.prototype._view_resource = function() {
        var response;
        response = this.root_doc.fetch();
        return response.done((function(_this) {
          return function() {
            var view;
            _this._make_editbar();
            _this._make_breadcrumbs();
            view = new Views.FrontDoorMainView({
              model: _this.root_doc
            });
            return _this._show_content(view);
          };
        })(this));
      };

      Controller.prototype.view_resource = function(resource) {
        this._set_resource(resource);
        return this._view_resource();
      };

      Controller.prototype.frontdoor = function() {
        this.root_doc.id = "";
        return this._view_resource();
      };

      Controller.prototype._manage_contents = function() {
        var response;
        response = this.root_doc.fetch();
        return response.done((function(_this) {
          return function() {
            var view;
            _this._make_editbar();
            _this._make_breadcrumbs();
            view = new Views.ContentsView({
              model: _this.root_doc
            });
            return _this._show_content(view);
          };
        })(this));
      };

      Controller.prototype.manage_contents = function(resource) {
        if (resource === null) {
          return this.manage_root_contents();
        }
        this._set_resource(resource);
        return this._manage_contents();
      };

      Controller.prototype.manage_root_contents = function() {
        this.root_doc.id = "";
        return this._manage_contents();
      };

      Controller.prototype.start = function() {
        return this.make_main_content();
      };

      return Controller;

    })(MainController);
    return module.exports = Controller;
  });

}).call(this);

//# sourceMappingURL=controller.js.map
