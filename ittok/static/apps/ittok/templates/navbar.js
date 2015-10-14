(function() {
  define(function(require, exports, module) {
    var $, _, dropdown_toggle, frontdoor_url, nav_pt, nav_pt_content, nav_pt_search, navbar_collapse_button, ref, tc;
    $ = require('jquery');
    _ = require('underscore');
    tc = require('teacup');
    ref = require('templates/common'), navbar_collapse_button = ref.navbar_collapse_button, dropdown_toggle = ref.dropdown_toggle, frontdoor_url = ref.frontdoor_url;
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
            href: '#frontdoor'
          }, relmeta.site_title);
        });
        return tc.div('#navbar-view-collapse.collapse.navbar-collapse', function() {
          tc.ul('.nav.navbar-nav', function() {
            var i, isactive, item, len, ref1, results;
            ref1 = relmeta.navitems;
            results = [];
            for (i = 0, len = ref1.length; i < len; i++) {
              item = ref1[i];
              isactive = "";
              if (item.inside) {
                isactive = ".active";
              }
              results.push(tc.li(isactive, function() {
                return tc.a({
                  href: frontdoor_url(item.path),
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
    return module.exports = {
      nav_pt_search: nav_pt_search,
      nav_pt: nav_pt
    };
  });

}).call(this);

//# sourceMappingURL=navbar.js.map
