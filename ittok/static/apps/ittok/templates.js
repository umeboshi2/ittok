(function() {
  define(function(require, exports, module) {
    var $, MainLayoutTemplate, _, actions_dropdown, add_dropdown, default_view_selector, dropdown_toggle, editor_bar_pt, editor_bar_pt_content, nav_pt, nav_pt_content, nav_pt_search, navbar_collapse_button, tc, user_menu, user_menu_dropdown, workflow_dropdown;
    $ = require('jquery');
    _ = require('underscore');
    tc = require('teacup');
    navbar_collapse_button = tc.renderable(function(target) {
      return tc.button('.navbar-toggle', {
        type: 'button',
        'data-toggle': 'collapse',
        'data-target': "#" + target
      }, function() {
        tc.span('.sr-only', 'Toggle Navigation');
        tc.span('.icon-bar');
        tc.span('.icon-bar');
        return tc.span('.icon-bar');
      });
    });
    dropdown_toggle = tc.component(function(selector, attrs, renderContents) {
      return tc.a(selector + ".dropdown-toggle", {
        href: attrs.href,
        'data-toggle': 'dropdown'
      }, renderContents);
    });
    nav_pt_search = tc.renderable(function(doc) {
      var relmeta;
      relmeta = doc.data.relationships.meta;
      return tc.form('#form-search.navbar-form.navbar-right', {
        role: 'search',
        method: 'post',
        action: relmeta.root_url + "@@search-results"
      }, function() {
        tc.div('.form-group', function() {
          return tc.input('.form-control', {
            name: 'search-term',
            type: 'search',
            placeholder: 'Search...'
          });
        });
        return tc.button('.btn.btn-default', {
          type: 'submit',
          name: 'search-submit',
          value: 'search',
          style: 'display: none;'
        }, function() {
          return tc.raw('&#8594');
        });
      });
    });
    nav_pt_content = tc.renderable(function(doc) {
      var relmeta;
      relmeta = doc.data.relationships.meta;
      return tc.div('.container-fluid', function() {
        tc.div('.navbar-header', function() {
          navbar_collapse_button('navbar-view-collapse');
          return tc.a('.navbar-brand', {
            href: relmeta.application_url
          }, relmeta.site_title);
        });
        return tc.div('#navbar-view-collapse.collapse.navbar-collapse', function() {
          tc.ul('.nav.navbar-nav', function() {
            var i, isactive, item, len, ref, results;
            ref = relmeta.navitems;
            results = [];
            for (i = 0, len = ref.length; i < len; i++) {
              item = ref[i];
              isactive = "";
              if (item.inside) {
                isactive = ".active";
              }
              results.push(tc.li(isactive, function() {
                return tc.a({
                  href: item.url,
                  title: item.description
                }, item.title);
              }));
            }
            return results;
          });
          tc.ul('#user-menu.nav.navbar-nav.navbar-right');
          return tc.div('#form-search-container');
        });
      });
    });
    nav_pt = tc.renderable(function(doc) {
      return tc.nav('#navbar-view.navbar.navbar-static-top.navbar-inverse', {
        xmlns: 'http://www.w3.org/1999/xhtml',
        'xml:lang': 'en',
        role: 'navigation'
      }, function() {
        return nav_pt_content(doc);
      });
    });
    workflow_dropdown = tc.renderable(function(doc) {
      var ref, relmeta, wf;
      relmeta = doc.data.relationships.meta;
      wf = relmeta.workflow;
      tc.li('.dropdown', function() {
        var ref;
        if (wf.current_state.current && ((ref = relmeta.has_permission) != null ? ref.state_change : void 0)) {
          dropdown_toggle(function() {
            return tc.span(".state-" + wf.current_state.name, function() {
              tc.text(wf.current_state.title);
              return tc.b('.caret');
            });
          });
          return tc.ul('.dropdown-menu', function() {
            var i, len, ref1, results, trans;
            ref1 = wf.transitions;
            results = [];
            for (i = 0, len = ref1.length; i < len; i++) {
              trans = ref1[i];
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
      if (wf.current_state.current && !((ref = relmeta.has_permission) != null ? ref.state_change : void 0)) {
        return tc.a(".state-" + wf.current_state.name, function() {
          return tc.text(wf.current_state.title);
        });
      }
    });
    default_view_selector = tc.renderable(function(doc) {
      var attrs, i, len, ref, relmeta, results, v;
      relmeta = doc.data.relationships.meta;
      tc.li('.divider');
      tc.li('.dropdown-header', {
        role: 'presentation'
      }, function() {
        return tc.text("Set default view");
      });
      ref = relmeta.selectable_default_views;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        v = ref[i];
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
          var i, len, link, ref;
          ref = relmeta.link_parent;
          for (i = 0, len = ref.length; i < len; i++) {
            link = ref[i];
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
          var i, len, link, ref;
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
            ref = relmeta.site_setup_links;
            for (i = 0, len = ref.length; i < len; i++) {
              link = ref[i];
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
      var relmeta;
      relmeta = doc.data.relationships.meta;
      return tc.div('.container-fluid', function() {
        tc.div('.navbar-header', function() {
          return navbar_collapse_button('navbar-edit');
        });
        return tc.div('#navbar-edit.collapse.navbar-collapse', function() {
          tc.ul('.nav.navbar-nav.navbar-left', function() {
            var i, isactive, len, link, ref;
            if (relmeta.has_permission.edit) {
              workflow_dropdown(doc);
            }
            isactive = '';
            if (relmeta.request_url === relmeta.api_url) {
              isactive = '.active';
            }
            tc.li(function() {
              return tc.a({
                href: relmeta.api_url
              }, "View");
            });
            ref = relmeta.edit_links;
            for (i = 0, len = ref.length; i < len; i++) {
              link = ref[i];
              tc.li(function() {
                return tc.a({
                  href: link.url
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
    user_menu = tc.renderable(function(doc) {
      var user;
      user = doc.data.relationships.meta.current_user;
      return tc.ul('#user-menu.ctx-menu.nav.navbar-nav', function() {
        return tc.li('.dropdown', function() {
          tc.a('.dropdown-toggle', {
            'data-toggle': 'dropdown'
          }, function() {
            if (user && 'title' in user) {
              return tc.text(user.title);
            } else {
              return tc.text("Guest");
            }
          });
          return tc.ul('.dropdown-menu', function() {
            if (user) {
              tc.li(function() {
                return tc.a({
                  href: "/"
                }, 'MainPage');
              });
              return tc.li(function() {
                return tc.a({
                  href: "/logout"
                }, "Logout");
              });
            } else {
              return tc.li(function() {
                return tc.a({
                  href: '/login'
                }, 'Login');
              });
            }
          });
        });
      });
    });
    return module.exports = {
      nav_pt_search: nav_pt_search,
      nav_pt: nav_pt,
      editor_bar_pt: editor_bar_pt,
      MainLayoutTemplate: MainLayoutTemplate,
      user_menu: user_menu
    };
  });

}).call(this);

//# sourceMappingURL=templates.js.map
