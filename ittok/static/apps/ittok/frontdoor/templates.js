(function() {
  define(function(require, exports, module) {
    var FolderViewTemplate, MainContentTemplate, frontdoor_main, marked, tc;
    tc = require('teacup');
    marked = require('marked');
    frontdoor_main = tc.renderable(function(content) {
      window.dcon = content;
      return tc.raw(content.data.attributes.body);
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
    FolderViewTemplate = tc.renderable(function(doc) {
      var atts;
      atts = doc.data.attributes;
      return tc.article('.document-view.content', function() {
        tc.h1(atts.title);
        tc.p('.lead', atts.description);
        tc.h2('Contents');
        return tc.div('.body', function() {
          return tc.table('.table.table-condensed', function() {
            tc.thead(function() {
              return tc.tr(function() {
                tc.th('Title');
                tc.th('Type');
                tc.th('Creation Date');
                return tc.th('Modification Date');
              });
            });
            return tc.tbody(function() {
              return null;
            });
          });
        });
      });
    });
    return module.exports = {
      frontdoor_main: frontdoor_main,
      MainContentTemplate: MainContentTemplate
    };
  });

}).call(this);

//# sourceMappingURL=templates.js.map
