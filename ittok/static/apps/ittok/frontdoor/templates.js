(function() {
  define(function(require, exports, module) {
    var frontdoor_main, marked, tc;
    tc = require('teacup');
    marked = require('marked');
    frontdoor_main = tc.renderable(function(page) {
      return tc.raw(marked(page.content));
    });
    return module.exports = {
      frontdoor_main: frontdoor_main
    };
  });

}).call(this);

//# sourceMappingURL=templates.js.map
