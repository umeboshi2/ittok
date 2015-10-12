(function() {
  define(function(require, exports, module) {
    var $, Backbone, BaseAppModel, _, appmodel, appregions, ft, jQuery;
    $ = require('jquery');
    jQuery = require('jquery');
    _ = require('underscore');
    Backbone = require('backbone');
    ft = require('furniture');
    BaseAppModel = ft.models.base.BaseAppModel;
    appregions = {
      mainview: 'body',
      navbar: '#navbar-view-container',
      editbar: '#editor-bar-container',
      sidebar: '#sidebar',
      content: '#main-content',
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
          appname: 'useradmin',
          name: 'Accounts',
          url: '#useradmin'
        }
      ],
      regions: appregions
    });
    return module.exports = appmodel;
  });

}).call(this);

//# sourceMappingURL=appmodel.js.map
