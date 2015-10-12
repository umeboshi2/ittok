(function() {
  define(function(require, exports, module) {
    var frontdoor_main, marked, tc;
    tc = require('teacup');
    marked = require('marked');
    frontdoor_main = tc.renderable(function(content) {
      window.dcon = content;
      return tc.raw(content.data.attributes.body);
    });
    return module.exports = {
      frontdoor_main: frontdoor_main
    };
  });

}).call(this);

//# sourceMappingURL=templates.js.map
