(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(function(require, exports, module) {
    var AppTemplates, Backbone, ContentsView, EditorView, MainChannel, Marionette, make_json_post, ref, remove_trailing_slashes, tableDnD;
    Backbone = require('backbone');
    Marionette = require('marionette');
    AppTemplates = require('editcontents/templates');
    tableDnD = require('tablednd');
    ref = require('util'), remove_trailing_slashes = ref.remove_trailing_slashes, make_json_post = ref.make_json_post;
    MainChannel = Backbone.Wreqr.radio.channel('global');
    ContentsView = (function(superClass) {
      extend(ContentsView, superClass);

      function ContentsView() {
        return ContentsView.__super__.constructor.apply(this, arguments);
      }

      ContentsView.prototype.template = AppTemplates.ContentsViewTemplate;

      ContentsView.prototype.ui = {
        toggle_all: '#toggle-all',
        contents_table: '#contents-table',
        contents_form: '#contents-form',
        checkboxes: 'input[type=checkbox]',
        child_checkboxes: 'input[type=checkbox][name="children"]',
        thumbnails: '.document-view.content img.thumb',
        action_buttons: '.action-button'
      };

      ContentsView.prototype.events = function() {
        return {
          'change @ui.toggle_all': 'toggle_all',
          'click .action-button': 'handle_action_button'
        };
      };

      ContentsView.prototype.toggle_all = function() {
        return this.ui.checkboxes.prop('checked', this.ui.toggle_all[0].checked);
      };

      ContentsView.prototype.handle_action_button = function(event) {
        var name;
        window.ae = event;
        name = event.currentTarget.getAttribute('name');
        console.log("NAME", name);
        window.checkboxes = this.ui.checkboxes;
        console.log("Serialize", this.ui.contents_form.serialize());
        return console.log("FIXME - implement action buttons");
      };

      ContentsView.prototype.onDomRefresh = function() {
        this.ui.thumbnails.popover({
          html: true,
          trigger: 'hover'
        });
        return this.ui.contents_table.tableDnD({
          onDrop: (function(_this) {
            return function(table, row) {
              var data, i, index, len, newPosition, oldPosition, postdata, relmeta, response, rows, this_path, url;
              rows = table.tBodies[0].rows;
              oldPosition = parseInt(row.id, 10);
              newPosition = parseInt(row.id, 10);
              index = 0;
              for (i = 0, len = rows.length; i < len; i++) {
                row = rows[i];
                if (parseInt(row.id, 10) === oldPosition) {
                  newPosition = index;
                  break;
                }
                index += 1;
              }
              data = _this.model.get('data');
              relmeta = data.relationships.meta;
              this_path = remove_trailing_slashes(relmeta.paths.this_path);
              url = this_path + "/@@move-child-position";
              postdata = {
                from: oldPosition,
                to: newPosition
              };
              response = make_json_post(url, postdata);
              response.done(function() {
                var level, msg;
                msg = "Moved from " + oldPosition + " to " + newPosition + " successfully!";
                level = 'info';
                return MainChannel.reqres.request('main:app:display-message', msg, level);
              });
              return response.fail(function() {
                return alert("Bad move!");
              });
            };
          })(this)
        });
      };

      return ContentsView;

    })(Backbone.Marionette.ItemView);
    EditorView = (function(superClass) {
      extend(EditorView, superClass);

      function EditorView() {
        return EditorView.__super__.constructor.apply(this, arguments);
      }

      EditorView.prototype.template = AppTemplates.ContentsViewTemplate;

      EditorView.prototype.ui = {
        toggle_all: '#toggle-all',
        contents_table: '#contents-table',
        contents_form: '#contents-form',
        checkboxes: 'input[type=checkbox]',
        child_checkboxes: 'input[type=checkbox][name="children"]',
        thumbnails: '.document-view.content img.thumb',
        action_buttons: '.action-button'
      };

      EditorView.prototype.events = function() {
        return {
          'change @ui.toggle_all': 'toggle_all',
          'click .action-button': 'handle_action_button'
        };
      };

      return EditorView;

    })(Backbone.Marionette.ItemView);
    return module.exports = {
      ContentsView: ContentsView,
      EditorView: EditorView
    };
  });

}).call(this);

//# sourceMappingURL=views.js.map
