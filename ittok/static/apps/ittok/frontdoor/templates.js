(function() {
  define(function(require, exports, module) {
    var DefaultViewTemplate, FolderViewTemplate, dropdown_toggle, editor_url, frontdoor_main, frontdoor_url, marked, navbar_collapse_button, ref, tc, workflow_dropdown;
    tc = require('teacup');
    marked = require('marked');
    ref = require('templates/common'), navbar_collapse_button = ref.navbar_collapse_button, dropdown_toggle = ref.dropdown_toggle, frontdoor_url = ref.frontdoor_url, editor_url = ref.editor_url;
    workflow_dropdown = require('templates/editorbar').workflow_dropdown;
    frontdoor_main = tc.renderable(function(content) {
      return tc.raw(content.data.attributes.body);
    });
    DefaultViewTemplate = tc.renderable(function(doc) {
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
      var atts, relmeta;
      atts = doc.data.attributes;
      relmeta = doc.data.relationships.meta;
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
              var child, href, i, len, ref1, results, type_info;
              ref1 = relmeta.children;
              results = [];
              for (i = 0, len = ref1.length; i < len; i++) {
                child = ref1[i];
                type_info = child.data.relationships.meta.type_info;
                href = frontdoor_url(child.path);
                results.push(tc.tr(function() {
                  tc.td(function() {
                    return tc.a({
                      href: href
                    }, child.data.attributes.title);
                  });
                  tc.td(function() {
                    return tc.a({
                      href: href
                    }, type_info.title);
                  });
                  tc.td(function() {
                    return tc.a({
                      href: href
                    }, child.meta.creation_date);
                  });
                  return tc.td(function() {
                    return tc.a({
                      href: href
                    }, child.meta.modification_date);
                  });
                }));
              }
              return results;
            });
          });
        });
      });
    });
    return module.exports = {
      frontdoor_main: frontdoor_main,
      DefaultViewTemplate: DefaultViewTemplate,
      FolderViewTemplate: FolderViewTemplate
    };
  });

}).call(this);

//# sourceMappingURL=templates.js.map
