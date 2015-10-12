(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var $, Backbone, BaseController, Controller, EditBarView, MainChannel, Marionette, Util, Views, ft, marked;
    $ = require('jquery');
    Backbone = require('backbone');
    Marionette = require('marionette');
    marked = require('marked');
    ft = require('furniture');
    MainChannel = Backbone.Wreqr.radio.channel('global');
    Views = require('frontdoor/views');
    EditBarView = require('views').EditBarView;
    Util = ft.util;
    BaseController = ft.controllers.base.BaseController;
    Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.mainbus = MainChannel;

      Controller.prototype._get_region = function(region) {
        return MainChannel.reqres.request('main:app:get-region', region);
      };

      Controller.prototype._show_content = function(view) {
        var content;
        content = this._get_region('content');
        return content.show(view);
      };

      Controller.prototype._make_editbar = function() {
        var data, editbar, user, view;
        data = this.root_doc.get('data');
        user = data.relationships.meta.current_user;
        console.log("_make_editbar", user);
        if (user && 'title' in user) {
          editbar = this._get_region('editbar');
          window.editbar = editbar;
          view = new EditBarView({
            model: this.root_doc
          });
          return editbar.show(view);
        }
      };

      Controller.prototype.make_main_content = function() {
        var view;
        this._make_editbar();
        console.log("Make_Main_Content");
        view = new Views.FrontDoorMainView({
          model: this.root_doc
        });
        return this._show_content(view);
      };

      Controller.prototype.start = function() {
        console.log('controller.start called');
        return this.make_main_content();
      };

      return Controller;

    })(BaseController);
    return module.exports = Controller;
  });

}).call(this);

//# sourceMappingURL=controller.js.map
