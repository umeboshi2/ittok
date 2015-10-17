(function() {
  define(function(require, exports, module) {
    var $, _, dropdown_toggle, editor_url, frontdoor_url, navbar_collapse_button, tc;
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
    frontdoor_url = function(path) {
      var stripped_path;
      stripped_path = path.replace(/\/$/, "");
      return "#frontdoor/view" + stripped_path;
    };
    editor_url = function(action, path) {
      var lstripped_path, rstripped_path;
      rstripped_path = path.replace(/\/$/, "");
      lstripped_path = rstripped_path.replace(/^\//, "");
      return "#editor/" + action + "/" + lstripped_path;
    };
    return module.exports = {
      navbar_collapse_button: navbar_collapse_button,
      dropdown_toggle: dropdown_toggle,
      frontdoor_url: frontdoor_url,
      editor_url: editor_url
    };
  });

}).call(this);

//# sourceMappingURL=common.js.map
