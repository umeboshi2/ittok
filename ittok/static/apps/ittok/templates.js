(function() {
  define(function(require, exports, module) {
    var $, BootstrapNavBarTemplate, MainLayoutTemplate, _, main_navbar_div, navbar_brand_div, navbar_items_div, tc, user_menu;
    $ = require('jquery');
    _ = require('underscore');
    tc = require('teacup');
    main_navbar_div = tc.renderable(function() {
      return tc.div("#main-navbar.navbar.navbar-default.navbar-fixed-top", {
        role: 'navigation'
      });
    });
    MainLayoutTemplate = tc.renderable(function() {
      main_navbar_div();
      tc.div('.container-fluid', function() {
        return tc.div('.row', function() {
          return tc.div('#main-content.col-md-12');
        });
      });
      tc.div('#footer');
      return tc.div('#modal');
    });
    navbar_brand_div = tc.renderable(function(name, url) {
      return tc.div('#navbar-brand.navbar-header', function() {
        tc.button('.navbar-toggle', {
          type: 'button',
          'data-toggle': 'collapse',
          'data-target': '.navbar-collapse'
        }, function() {
          tc.span('.sr-only', 'Toggle Navigation');
          tc.span('.icon-bar');
          tc.span('.icon-bar');
          return tc.span('.icon-bar');
        });
        return tc.a('.navbar-brand', {
          href: url
        }, name);
      });
    });
    navbar_items_div = tc.renderable(function(items) {
      return tc.div('.navbar-collapse.collapse', function() {
        tc.ul('#app-navbar.nav.navbar-nav', function() {
          var attrs, i, item, len, results;
          results = [];
          for (i = 0, len = items.length; i < len; i++) {
            item = items[i];
            attrs = {};
            if (item != null ? item.appname : void 0) {
              attrs.appname = item.appname;
            }
            results.push(tc.li(attrs, function() {
              return tc.a({
                href: item.url
              }, item.name);
            }));
          }
          return results;
        });
        tc.ul('#main-menu.nav.navbar-nav.navbar-left');
        return tc.ul('#user-menu.nav.navbar-nav.navbar-right');
      });
    });
    BootstrapNavBarTemplate = tc.renderable(function(model) {
      window.foomodel = model;
      navbar_brand_div(model.brand.name, model.brand.url);
      return navbar_items_div(model.applets);
    });
    user_menu = tc.renderable(function(user) {
      return tc.ul('#user-menu.ctx-menu.nav.navbar-nav', function() {
        return tc.li('.dropdown', function() {
          tc.a('.dropdown-toggle', {
            'data-toggle': 'dropdown'
          }, function() {
            if ('title' in user) {
              return tc.text(user.title);
            } else {
              return tc.text("Guest");
            }
          });
          return tc.ul('.dropdown-menu', function() {
            if ('title' in user) {
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
      main_navbar_div: main_navbar_div,
      MainLayoutTemplate: MainLayoutTemplate,
      BootstrapNavBarTemplate: BootstrapNavBarTemplate,
      user_menu: user_menu
    };
  });

}).call(this);

//# sourceMappingURL=templates.js.map
