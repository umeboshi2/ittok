(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var Backbone, BootstrapNavBarView, EditBarView, MainPageLayout, MainSearchFormView, Marionette, Templates, UserMenuView;
    Backbone = require('backbone');
    Marionette = require('marionette');
    Templates = require('templates');
    MainPageLayout = (function(superClass) {
      extend(MainPageLayout, superClass);

      function MainPageLayout() {
        return MainPageLayout.__super__.constructor.apply(this, arguments);
      }

      MainPageLayout.prototype.template = Templates.MainLayoutTemplate;

      return MainPageLayout;

    })(Backbone.Marionette.LayoutView);
    BootstrapNavBarView = (function(superClass) {
      extend(BootstrapNavBarView, superClass);

      function BootstrapNavBarView() {
        return BootstrapNavBarView.__super__.constructor.apply(this, arguments);
      }

      BootstrapNavBarView.prototype.template = Templates.nav_pt;

      BootstrapNavBarView.prototype.regions = {
        usermenu: '#user-menu',
        mainmenu: '#main-menu'
      };

      return BootstrapNavBarView;

    })(Backbone.Marionette.LayoutView);
    MainSearchFormView = (function(superClass) {
      extend(MainSearchFormView, superClass);

      function MainSearchFormView() {
        return MainSearchFormView.__super__.constructor.apply(this, arguments);
      }

      MainSearchFormView.prototype.template = Templates.nav_pt_search;

      return MainSearchFormView;

    })(Backbone.Marionette.ItemView);
    EditBarView = (function(superClass) {
      extend(EditBarView, superClass);

      function EditBarView() {
        return EditBarView.__super__.constructor.apply(this, arguments);
      }

      EditBarView.prototype.template = Templates.editor_bar_pt;

      return EditBarView;

    })(Backbone.Marionette.LayoutView);
    UserMenuView = (function(superClass) {
      extend(UserMenuView, superClass);

      function UserMenuView() {
        return UserMenuView.__super__.constructor.apply(this, arguments);
      }

      UserMenuView.prototype.template = Templates.user_menu;

      return UserMenuView;

    })(Backbone.Marionette.ItemView);
    return module.exports = {
      MainPageLayout: MainPageLayout,
      MainSearchFormView: MainSearchFormView,
      EditBarView: EditBarView,
      BootstrapNavBarView: BootstrapNavBarView,
      UserMenuView: UserMenuView
    };
  });

}).call(this);

//# sourceMappingURL=views.js.map
