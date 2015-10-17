(function() {
  define(function(require, exports, module) {
    var $, MainContentTemplate, MainLayoutTemplate, _, tc;
    $ = require('jquery');
    _ = require('underscore');
    tc = require('teacup');
    MainLayoutTemplate = tc.renderable(function() {
      tc.div('#navbar-view-container');
      tc.div('#editor-bar-container');
      tc.div('.container', function() {
        tc.div('#breadcrumbs');
        return tc.div('.row', function() {
          tc.div('col-md-12', function() {
            return tc.div('#messages');
          });
          tc.div('#main-content.col-md-9');
          return tc.div('#right-slot.col-md-3.right-column');
        });
      });
      tc.div('#footer');
      return tc.div('#modal');
    });
    MainContentTemplate = tc.renderable(function(doc) {
      var atts;
      atts = doc.data.attributes;
      return tc.article('.document-view.content', function() {
        tc.h1(atts.title);
        tc.p('.lead', atts.description);
        return tc.div('.body', function() {
          return tc.raw(atts.body);
        });
      });
    });
    return module.exports = {
      MainLayoutTemplate: MainLayoutTemplate,
      MainContentTemplate: MainContentTemplate
    };
  });

}).call(this);

//# sourceMappingURL=layout.js.map
