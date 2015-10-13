(function() {
  define(function(require, exports, module) {
    var $, _, dropdown_toggle, navbar_collapse_button, tc;
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
    return module.exports = {
      navbar_collapse_button: navbar_collapse_button,
      dropdown_toggle: dropdown_toggle
    };
  });

}).call(this);

//# sourceMappingURL=common.js.map
