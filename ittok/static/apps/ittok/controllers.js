(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var $, Backbone, BaseController, MainChannel, MainController, MainViews, Marionette, Util, Views, marked;
    $ = require('jquery');
    Backbone = require('backbone');
    Marionette = require('marionette');
    marked = require('marked');
    MainChannel = Backbone.Wreqr.radio.channel('global');
    Views = require('frontdoor/views');
    MainViews = require('views');
    Util = require('util');
    BaseController = (function(superClass) {
      extend(BaseController, superClass);

      function BaseController() {
        return BaseController.__super__.constructor.apply(this, arguments);
      }

      BaseController.prototype.init_page = function() {};

      BaseController.prototype.scroll_top = Util.scroll_top_fast;

      BaseController.prototype.navigate_to_url = Util.navigate_to_url;

      BaseController.prototype.navbar_set_active = Util.navbar_set_active;

      return BaseController;

    })(Backbone.Marionette.Object);
    MainController = (function(superClass) {
      extend(MainController, superClass);

      function MainController() {
        return MainController.__super__.constructor.apply(this, arguments);
      }

      MainController.prototype.mainbus = MainChannel;

      MainController.prototype._get_region = function(region) {
        return MainChannel.reqres.request('main:app:get-region', region);
      };

      MainController.prototype._show_content = function(view) {
        var content;
        content = this._get_region('content');
        return content.show(view);
      };

      MainController.prototype._make_editbar = function() {
        var data, editbar, user, view;
        data = this.root_doc.get('data');
        user = data.relationships.meta.current_user;
        editbar = this._get_region('editbar');
        if (user && 'title' in user) {
          view = new MainViews.EditBarView({
            model: this.root_doc
          });
          return editbar.show(view);
        } else {
          return editbar.empty();
        }
      };

      MainController.prototype._make_breadcrumbs = function() {
        var bc, breadcrumbs, data, view;
        data = this.root_doc.get('data');
        breadcrumbs = data.relationships.meta.breadcrumbs;
        bc = this._get_region('breadcrumbs');
        if (breadcrumbs.length > 1) {
          view = new MainViews.BreadCrumbView({
            model: this.root_doc
          });
          return bc.show(view);
        } else {
          return bc.empty();
        }
      };

      return MainController;

    })(BaseController);
    return module.exports = {
      BaseController: BaseController,
      MainController: MainController
    };
  });

}).call(this);

//# sourceMappingURL=controllers.js.map
