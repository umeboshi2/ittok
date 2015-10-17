(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var Backbone, FDTemplates, FolderView, FrontDoorMainView, MainChannel, Marionette, make_json_post, ref, remove_trailing_slashes, tableDnD;
    Backbone = require('backbone');
    Marionette = require('marionette');
    FDTemplates = require('frontdoor/templates');
    tableDnD = require('tablednd');
    ref = require('util'), remove_trailing_slashes = ref.remove_trailing_slashes, make_json_post = ref.make_json_post;
    MainChannel = Backbone.Wreqr.radio.channel('global');
    FrontDoorMainView = (function(superClass) {
      extend(FrontDoorMainView, superClass);

      function FrontDoorMainView() {
        return FrontDoorMainView.__super__.constructor.apply(this, arguments);
      }

      FrontDoorMainView.prototype.template = FDTemplates.DefaultViewTemplate;

      return FrontDoorMainView;

    })(Backbone.Marionette.ItemView);
    FolderView = (function(superClass) {
      extend(FolderView, superClass);

      function FolderView() {
        return FolderView.__super__.constructor.apply(this, arguments);
      }

      FolderView.prototype.template = FDTemplates.FolderViewTemplate;

      return FolderView;

    })(Backbone.Marionette.ItemView);
    return module.exports = {
      FrontDoorMainView: FrontDoorMainView,
      FolderView: FolderView
    };
  });

}).call(this);

//# sourceMappingURL=views.js.map
