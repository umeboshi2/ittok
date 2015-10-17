(function() {
  define(function(require, exports, module) {
    var $, MainLayoutTemplate, _, actions_dropdown, add_dropdown, breadcrumbs, default_view_selector, dropdown_toggle, editor_bar_pt, editor_bar_pt_content, editor_url, frontdoor_url, navbar_collapse_button, ref, tc, user_menu_dropdown, workflow_dropdown;
    $ = require('jquery');
    _ = require('underscore');
    tc = require('teacup');
    ref = require('templates/common'), navbar_collapse_button = ref.navbar_collapse_button, dropdown_toggle = ref.dropdown_toggle, frontdoor_url = ref.frontdoor_url, editor_url = ref.editor_url;
    workflow_dropdown = tc.renderable(function(doc) {
      var ref1, relmeta, wf;
      relmeta = doc.data.relationships.meta;
      wf = relmeta.workflow;
      tc.li('.dropdown', function() {
        var ref1;
        if (wf.current_state.current && ((ref1 = relmeta.has_permission) != null ? ref1.state_change : void 0)) {
          dropdown_toggle(function() {
            return tc.span(".state-" + wf.current_state.name, function() {
              tc.text(wf.current_state.title);
              return tc.b('.caret');
            });
          });
          return tc.ul('.dropdown-menu', function() {
            var i, len, ref2, results, trans;
            ref2 = wf.transitions;
            results = [];
            for (i = 0, len = ref2.length; i < len; i++) {
              trans = ref2[i];
              results.push(tc.li(function() {
                return tc.a({
                  href: "#workflow-change"
                }, function() {
                  tc.text("Make ");
                  return tc.span(wf.states[trans.to_state]['title']);
                });
              }));
            }
            return results;
          });
        }
      });
      if (wf.current_state.current && !((ref1 = relmeta.has_permission) != null ? ref1.state_change : void 0)) {
        return tc.a(".state-" + wf.current_state.name, function() {
          return tc.text(wf.current_state.title);
        });
      }
    });
    default_view_selector = tc.renderable(function(doc) {
      var attrs, i, len, ref1, relmeta, results, v;
      relmeta = doc.data.relationships.meta;
      tc.li('.divider');
      tc.li('.dropdown-header', {
        role: 'presentation'
      }, function() {
        return tc.text("Set default view");
      });
      ref1 = relmeta.selectable_default_views;
      results = [];
      for (i = 0, len = ref1.length; i < len; i++) {
        v = ref1[i];
        attrs = {};
        if (!v.is_current) {
          attrs.href = '@@@set-default-view';
        }
        results.push(tc.li(function() {
          return tc.a(attrs, function() {
            tc.text(v.title);
            if (v.is_current) {
              return tc.b('.glyphicon.glyphicon-ok.pull-right');
            }
          });
        }));
      }
      return results;
    });
    actions_dropdown = tc.renderable(function(doc) {
      var relmeta;
      relmeta = doc.data.relationships.meta;
      return tc.li('.dropdown', function() {
        dropdown_toggle(function() {
          tc.span("Actions");
          return tc.b(".caret");
        });
        return tc.ul('.dropdown-menu', function() {
          var i, len, link, ref1;
          ref1 = relmeta.link_parent;
          for (i = 0, len = ref1.length; i < len; i++) {
            link = ref1[i];
            tc.li(function() {
              return tc.a({
                href: link.url
              }, link.title);
            });
          }
          return default_view_selector(doc);
        });
      });
    });
    add_dropdown = tc.renderable(function(doc) {
      var factories, relmeta;
      relmeta = doc.data.relationships.meta;
      factories = relmeta.content_type_factories;
      return tc.li('.dropdown', function() {
        dropdown_toggle(function() {
          tc.span('Add');
          return tc.b('.caret');
        });
        return tc.ul('.dropdown-menu', function() {
          var factory, i, len;
          for (i = 0, len = factories.length; i < len; i++) {
            factory = factories[i];
            tc.li(function() {
              return tc.a({
                href: factory.url
              }, factory.title);
            });
          }
          if (factories) {
            tc.li('.divider');
            return tc.li(function() {
              return tc.a({
                href: relmeta.upload_url
              }, 'Upload Content');
            });
          }
        });
      });
    });
    user_menu_dropdown = tc.renderable(function(doc) {
      var relmeta, user;
      relmeta = doc.data.relationships.meta;
      user = relmeta.current_user;
      return tc.li('.dropdown.pull-right', function() {
        dropdown_toggle(function() {
          tc.text(user.title);
          return tc.b('.caret');
        });
        return tc.ul('#user-dropdown.dropdown-menu', function() {
          var i, len, link, ref1;
          tc.li(function() {
            return tc.a({
              href: user.prefs_url
            }, function() {
              tc.i('.fa.fa-gears.fa-fw');
              return tc.span("Preferences");
            });
          });
          if (relmeta.has_permission.admin) {
            tc.li('.divider');
            tc.li('.dropdown-header', {
              role: 'presentation'
            }, function() {
              return tc.text("Site Setup");
            });
            ref1 = relmeta.site_setup_links;
            for (i = 0, len = ref1.length; i < len; i++) {
              link = ref1[i];
              tc.li(function() {
                return tc.a({
                  href: link.url
                }, link.title);
              });
            }
          }
          return tc.li(function() {
            return tc.a({
              href: '/@@logout'
            }, function() {
              tc.i('.fa.fa-sign-out.fa-fw');
              return tc.span('Logout');
            });
          });
        });
      });
    });
    editor_bar_pt_content = tc.renderable(function(doc) {
      var relmeta, this_path;
      relmeta = doc.data.relationships.meta;
      this_path = relmeta.paths.this_path;
      return tc.div('.container-fluid', function() {
        tc.div('.navbar-header', function() {
          return navbar_collapse_button('navbar-edit');
        });
        return tc.div('#navbar-edit.collapse.navbar-collapse', function() {
          tc.ul('.nav.navbar-nav.navbar-left', function() {
            var i, isactive, len, link, ref1;
            if (relmeta.has_permission.edit) {
              workflow_dropdown(doc);
            }
            isactive = '';
            if (relmeta.request_url === relmeta.api_url) {
              isactive = '.active';
            }
            tc.li(function() {
              var href;
              href = frontdoor_url(this_path);
              return tc.a({
                href: href
              }, "View");
            });
            ref1 = relmeta.edit_links;
            for (i = 0, len = ref1.length; i < len; i++) {
              link = ref1[i];
              tc.li(function() {
                var href;
                href = editor_url(link.name, this_path);
                return tc.a({
                  href: href
                }, link.title);
              });
            }
            if (relmeta.has_permission.edit) {
              actions_dropdown(doc);
            }
            if (relmeta.has_permission.add) {
              tc.li('.divider-vertical');
              return add_dropdown(doc);
            }
          });
          return tc.ul('.nav.navbar-nav.navbar-right', function() {
            var liclass;
            liclass = '.pull-right';
            if (relmeta.request_url === relmeta.navigate_url) {
              liclass = liclass + ".active";
            }
            tc.li(liclass, function() {
              return tc.a({
                href: relmeta.navigate_url
              }, "Navigate");
            });
            return user_menu_dropdown(doc);
          });
        });
      });
    });
    editor_bar_pt = tc.renderable(function(doc) {
      return tc.nav('#editor-bar.navbar.navbar-default.navbar-static-top', function() {
        return editor_bar_pt_content(doc);
      });
    });
    MainLayoutTemplate = tc.renderable(function() {
      tc.div('#navbar-view-container');
      tc.div('#editor-bar-container');
      tc.div('.container', function() {
        tc.div('#breadcrumbs');
        return tc.div('.row', function() {
          tc.div('#main-content.col-md-9');
          return tc.div('#right-slot.col-md-3.right-column');
        });
      });
      tc.div('#footer');
      return tc.div('#modal');
    });
    breadcrumbs = tc.renderable(function(doc) {
      var relmeta;
      relmeta = doc.data.relationships.meta;
      return tc.ol('.breadcrumb', function() {
        var i, item, len, ref1, results;
        tc.small('You are here:  ');
        ref1 = relmeta.breadcrumbs;
        results = [];
        for (i = 0, len = ref1.length; i < len; i++) {
          item = ref1[i];
          results.push(tc.li(function() {
            return tc.a({
              href: item.url
            }, item.title);
          }));
        }
        return results;
      });
    });
    return module.exports = {
      workflow_dropdown: workflow_dropdown,
      editor_bar_pt: editor_bar_pt
    };
  });

}).call(this);

//# sourceMappingURL=editorbar.js.map
