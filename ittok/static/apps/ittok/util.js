(function() {
  define(function(require, exports, module) {
    var $, Backbone, _, camel_to_kebab, capitalize, handle_newlines, make_json_post, make_json_post_settings, navbar_set_active, navigate_to_url, remove_trailing_slashes, scroll_top_fast;
    $ = require('jquery');
    _ = require('underscore');
    Backbone = require('backbone');
    scroll_top_fast = function() {
      return $('html, body').animate({
        scrollTop: 0
      }, 'fast');
    };
    navigate_to_url = function(url) {
      var r;
      if (url.split('/')[0] === '') {
        return window.location = url;
      } else {
        r = new Backbone.Router;
        return r.navigate(url, {
          trigger: true
        });
      }
    };
    capitalize = function(str) {
      return str.charAt(0).toUpperCase() + str.slice(1);
    };
    handle_newlines = function(str) {
      return str.replace(/(?:\r\n|\r|\n)/g, '<br />');
    };
    camel_to_kebab = function(str) {
      return str.replace(/([A-Z])/g, function($1) {
        return "-" + ($1.toLowerCase());
      });
    };
    navbar_set_active = function(path) {
      var i, len, li, liq, path_top, ref, results;
      path_top = path.split('/')[0];
      ref = $('#app-navbar li');
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        li = ref[i];
        liq = $(li);
        liq.removeClass('active');
        if (path_top === liq.attr('appname')) {
          results.push(liq.addClass('active'));
        } else {
          results.push(void 0);
        }
      }
      return results;
    };
    make_json_post_settings = function(url, data, type) {
      var settings;
      if (type == null) {
        type = 'POST';
      }
      settings = {
        type: type,
        url: url,
        data: JSON.stringify(data),
        accepts: 'application/json',
        contentType: 'application/json'
      };
      return settings;
    };
    make_json_post = function(url, data, type) {
      var settings;
      if (type == null) {
        type = 'POST';
      }
      settings = make_json_post_settings(url, data, type);
      return $.ajax(settings);
    };
    remove_trailing_slashes = function(path) {
      return path.replace(/\/$/, "");
    };
    return module.exports = {
      scroll_top_fast: scroll_top_fast,
      navigate_to_url: navigate_to_url,
      capitalize: capitalize,
      handle_newlines: handle_newlines,
      camel_to_kebab: camel_to_kebab,
      navbar_set_active: navbar_set_active,
      make_json_post_settings: make_json_post_settings,
      make_json_post: make_json_post,
      remove_trailing_slashes: remove_trailing_slashes
    };
  });

}).call(this);

//# sourceMappingURL=util.js.map
