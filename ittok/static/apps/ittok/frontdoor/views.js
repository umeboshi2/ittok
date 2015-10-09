(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var Backbone, BaseSideBarView, FDTemplates, FrontDoorMainView, Marionette, SideBarView, ft;
    Backbone = require('backbone');
    Marionette = require('marionette');
    ft = require('furniture');
    FDTemplates = require('frontdoor/templates');
    BaseSideBarView = ft.views.sidebar;
    FrontDoorMainView = (function(superClass) {
      extend(FrontDoorMainView, superClass);

      function FrontDoorMainView() {
        return FrontDoorMainView.__super__.constructor.apply(this, arguments);
      }

      FrontDoorMainView.prototype.template = FDTemplates.frontdoor_main;

      return FrontDoorMainView;

    })(Backbone.Marionette.ItemView);
    SideBarView = (function(superClass) {
      extend(SideBarView, superClass);

      function SideBarView() {
        return SideBarView.__super__.constructor.apply(this, arguments);
      }

      return SideBarView;

    })(BaseSideBarView);
    return module.exports = {
      FrontDoorMainView: FrontDoorMainView,
      SideBarView: SideBarView
    };
  });

}).call(this);

//# sourceMappingURL=views.js.map
