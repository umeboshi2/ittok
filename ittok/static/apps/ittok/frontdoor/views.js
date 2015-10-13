(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var Backbone, FDTemplates, FrontDoorMainView, Marionette;
    Backbone = require('backbone');
    Marionette = require('marionette');
    FDTemplates = require('frontdoor/templates');
    FrontDoorMainView = (function(superClass) {
      extend(FrontDoorMainView, superClass);

      function FrontDoorMainView() {
        return FrontDoorMainView.__super__.constructor.apply(this, arguments);
      }

      FrontDoorMainView.prototype.template = FDTemplates.MainContentTemplate;

      return FrontDoorMainView;

    })(Backbone.Marionette.ItemView);
    return module.exports = {
      FrontDoorMainView: FrontDoorMainView
    };
  });

}).call(this);

//# sourceMappingURL=views.js.map
