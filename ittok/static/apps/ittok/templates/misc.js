(function() {
  define(function(require, exports, module) {
    var $, _, breadcrumbs, dropdown_toggle, frontdoor_url, ref, tc, user_menu;
    $ = require('jquery');
    _ = require('underscore');
    tc = require('teacup');
    ref = require('templates/common'), dropdown_toggle = ref.dropdown_toggle, frontdoor_url = ref.frontdoor_url;
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
    breadcrumbs = tc.renderable(function(doc) {
      return tc.ol('.breadcrumb', function() {
        var i, item, len, ref1, results;
        tc.small('You are here:  ');
        ref1 = doc.data.relationships.meta.breadcrumbs;
        results = [];
        for (i = 0, len = ref1.length; i < len; i++) {
          item = ref1[i];
          results.push(tc.li(function() {
            return tc.a({
              href: frontdoor_url(item.path)
            }, item.title);
          }));
        }
        return results;
      });
    });
    return module.exports = {
      user_menu: user_menu,
      breadcrumbs: breadcrumbs
    };
  });

}).call(this);

//# sourceMappingURL=misc.js.map
