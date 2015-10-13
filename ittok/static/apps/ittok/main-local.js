(function() {
  var components;

  components = '../../components';

  require.config({
    baseUrl: '/fanstatic/ittok/apps/ittok',
    paths: {
      ace: components + "/ace-builds/src-min",
      backbone: components + "/backbone/backbone",
      'backbone.babysitter': components + "/backbone.babysitter/lib/backbone.babysitter",
      'backbone.paginator': components + "/backbone.paginator/lib/backbone.paginator",
      'backbone.wreqr': components + "/backbone.wreqr/lib/backbone.wreqr",
      bblocalStorage: components + "/backbone.localStorage/backbone.localStorage",
      bootstrap: components + "/bootstrap/dist/js/bootstrap",
      'doc-ready': components + "/doc-ready",
      eventEmitter: components + "/eventEmitter",
      eventie: components + "/eventie",
      'fizzy-ui-utils': components + "/fizzy-ui-utils",
      fullcalendar: components + "/fullcalendar/dist/fullcalendar",
      furniture: components + "/furniture/dist/furniture",
      'get-size': components + "/get-size",
      'get-style-property': components + "/get-style-property",
      imagesloaded: components + "/imagesloaded/imagesloaded",
      jquery: components + "/jquery/dist/jquery",
      'jquery-ui': components + "/jquery-ui/jquery-ui",
      marionette: components + "/backbone.marionette/lib/core/backbone.marionette",
      marked: components + "/marked/lib/marked",
      masonry: components + "/masonry/masonry",
      'matches-selector': components + "/matches-selector",
      moment: components + "/moment/moment",
      outlayer: components + "/outlayer",
      requirejs: components + "/requirejs/require",
      teacup: components + "/teacup/lib/teacup",
      underscore: components + "/underscore/underscore",
      validation: components + "/backbone.validation/dist/backbone-validation-amd",
      qs: components + "/qs/dist/qs",
      'bootstrap-fileinput': components + "/bootstrap-fileinput/js/fileinput.min",
      'json-editor': components + "/json-editor/dist/jsoneditor"
    },
    shim: {
      jquery: {
        exports: ['$', 'jQuery']
      },
      bootstrap: {
        deps: ['jquery']
      },
      underscore: {
        exports: '_'
      },
      backbone: {
        deps: ['jquery', 'underscore'],
        exports: 'Backbone'
      },
      marionette: {
        deps: ['jquery', 'underscore', 'backbone'],
        exports: 'Marionette'
      },
      bblocalStorage: {
        deps: ['backbone'],
        exports: 'Backbone.localStorage'
      },
      'bootstrap-fileinput': {
        deps: ['jquery', 'bootstrap']
      },
      'json-editor': {
        deps: ['jquery', 'bootstrap'],
        exports: 'JSONEditor'
      }
    },
    deps: ['require'],
    callback: function(require) {
      'use strict';
      var filename, modulename;
      filename = location.pathname.match(/\/([^\/]*)$/);
      console.log("Filename " + filename, location.pathname);
      modulename = void 0;
      if (filename && filename[1] !== "" || filename[0] === '/') {
        modulename = ["application"].join("/");
        require([modulename], function(App) {
          return App;
        });
      } else {
        if (window.console) {
          console.log("no modulename found via location.pathname");
        }
      }
    }
  });

}).call(this);

//# sourceMappingURL=main-local.js.map
