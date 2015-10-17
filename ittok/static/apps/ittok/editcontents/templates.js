(function() {
  define(function(require, exports, module) {
    var ContentsViewTemplate, button_icons, dropdown_toggle, editor_url, frontdoor_url, marked, navbar_collapse_button, popover_image, ref, tc, workflow_dropdown;
    tc = require('teacup');
    marked = require('marked');
    ref = require('templates/common'), navbar_collapse_button = ref.navbar_collapse_button, dropdown_toggle = ref.dropdown_toggle, frontdoor_url = ref.frontdoor_url, editor_url = ref.editor_url;
    workflow_dropdown = require('templates/editorbar').workflow_dropdown;
    button_icons = {
      paste: 'fa-paste',
      copy: 'fa-copy',
      cut: 'fa-cut',
      rename_nodes: 'fa-pencil-square-o',
      delete_nodes: 'fa-remove',
      change_state: 'fa-bicycle',
      up: 'fa-arrow-up',
      down: 'fa-arrow-down',
      show: 'fa-eye',
      hide: 'fa-eye-slash'
    };
    popover_image = tc.renderable(function(url) {
      return tc.img({
        src: url
      });
    });
    ContentsViewTemplate = tc.renderable(function(doc) {
      var atts, lineage, relmeta;
      atts = doc.data.attributes;
      relmeta = doc.data.relationships.meta;
      lineage = relmeta.lineage.slice();
      lineage.reverse();
      return tc.div('.document-view.content', function() {
        tc.h1(atts.title);
        tc.p('.lead', atts.description);
        tc.h2('Contents');
        return tc.div('.body', function() {
          tc.div('#contents-path', function() {
            var first, i, item, last, len, results;
            first = lineage[0], last = lineage[lineage.length - 1];
            results = [];
            for (i = 0, len = lineage.length; i < len; i++) {
              item = lineage[i];
              results.push(tc.a('.btn.btn-default.btn-small', {
                name: item.name,
                href: editor_url('contents', item.path)
              }, function() {
                if (item.id === (first != null ? first.id : void 0)) {
                  tc.i('.fa.fa-home.fa-fw');
                }
                if (!(item.id === (first != null ? first.id : void 0) || item.id === (last != null ? last.id : void 0))) {
                  tc.i('.fa.fa-folder.fa-fw');
                }
                if (item.id === (last != null ? last.id : void 0) && item.id !== (first != null ? first.id : void 0)) {
                  tc.i('.fa.fa-folder-open-o.fa-fw');
                }
                return tc.text(item.title);
              }));
            }
            return results;
          });
          return tc.form('#contents-form', function() {
            var tclasses;
            if (relmeta.children.length) {
              tclasses = "table.table-condensed.table-striped.table-hover";
              tc.table("#contents-table." + tclasses, function() {
                tc.thead(function() {
                  return tc.tr(function() {
                    tc.th(function() {
                      return tc.input('#toggle-all', {
                        type: 'checkbox',
                        title: 'Select / deselect all'
                      });
                    });
                    tc.th('Title');
                    tc.th('Type');
                    tc.th('State');
                    tc.th('Visibility');
                    tc.th('Creation Date');
                    return tc.th('Modification Date');
                  });
                });
                return tc.tbody(function() {
                  var child, i, len, ref1, results, type_info;
                  ref1 = relmeta.children;
                  results = [];
                  for (i = 0, len = ref1.length; i < len; i++) {
                    child = ref1[i];
                    type_info = child.data.relationships.meta.type_info;
                    results.push(tc.tr("#" + child.position, function() {
                      tc.td(function() {
                        return tc.input({
                          name: 'children',
                          type: 'checkbox',
                          value: child.data.id,
                          title: child.data.attributes.title
                        });
                      });
                      tc.td(function() {
                        var imgtag;
                        tc.a({
                          href: editor_url('contents', child.path)
                        }, function() {
                          return tc.text(child.data.attributes.title);
                        });
                        if (type_info.name === 'Image') {
                          imgtag = "<img src=\"" + type_info.image_span4_url + "\">";
                          tc.br();
                          return tc.img('.thumb', {
                            src: type_info.image_span1_url,
                            'data-content': imgtag,
                            title: child.data.attributes.title
                          });
                        }
                      });
                      tc.td(type_info.title);
                      tc.td(function() {
                        var lstyle;
                        lstyle = 'list-style-type: none; padding: 0; margin: 0;';
                        return tc.ul({
                          style: lstyle
                        }, function() {
                          return workflow_dropdown(doc);
                        });
                      });
                      tc.td(function() {
                        if (child.meta.in_navigation) {
                          tc.i('.fa.fa-eye');
                          return tc.span('Visible');
                        } else {
                          tc.i('.fa.fa-eye-slash');
                          return tc.span('Hidden');
                        }
                      });
                      tc.td(child.meta.creation_date);
                      return tc.td(child.meta.modification_date);
                    }));
                  }
                  return results;
                });
              });
              return tc.div(".btn-group", function() {
                var btn, i, len, ref1, results;
                ref1 = relmeta.contents_buttons;
                results = [];
                for (i = 0, len = ref1.length; i < len; i++) {
                  btn = ref1[i];
                  results.push(tc.div(".action-button." + (btn.css_classes.join('.')) + ".btn-sm", {
                    name: btn.name
                  }, function() {
                    tc.i(".fa." + button_icons[btn.name] + ".fa-fw");
                    return tc.small(function() {
                      return tc.text(btn.title);
                    });
                  }));
                }
                return results;
              });
            }
          });
        });
      });
    });
    return module.exports = {
      ContentsViewTemplate: ContentsViewTemplate
    };
  });

}).call(this);

//# sourceMappingURL=templates.js.map
