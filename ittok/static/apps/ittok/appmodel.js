(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var $, Backbone, BaseAppModel, _, appmodel, appregions, jQuery;
    $ = require('jquery');
    jQuery = require('jquery');
    _ = require('underscore');
    Backbone = require('backbone');
    BaseAppModel = (function(superClass) {
      extend(BaseAppModel, superClass);

      function BaseAppModel() {
        return BaseAppModel.__super__.constructor.apply(this, arguments);
      }

      BaseAppModel.prototype.defaults = {
        brand: {
          name: 'Brand',
          url: '/'
        },
        frontdoor_app: 'frontdoor',
        hasUser: false,
        frontdoor_sidebar: [
          {
            name: 'Home',
            url: '/'
          }
        ],
        applets: [],
        regions: {},
        routes: []
      };

      return BaseAppModel;

    })(Backbone.Model);
    appregions = {
      mainview: 'body',
      navbar: '#navbar-view-container',
      editbar: '#editor-bar-container',
      sidebar: '#sidebar',
      breadcrumbs: '#breadcrumbs',
      content: '#main-content',
      messages: '#messages',
      footer: '#footer',
      modal: '#modal',
      usermenu: '#user-menu',
      search: '#form-search-container'
    };
    appmodel = new BaseAppModel({
      hasUser: true,
      brand: {
        name: 'Kotti',
        url: '/'
      },
      applets: [
        {
          appname: 'editcontents',
          name: 'Edit Contents',
          url: '#editor'
        }
      ],
      regions: appregions
    });
    return module.exports = appmodel;
  });

}).call(this);

//# sourceMappingURL=appmodel.js.map
