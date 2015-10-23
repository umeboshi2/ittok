FormView = require 'marionette-form-view'

class BootstrapFormView extends FormView
  valid: (view, attr, selector) =>
    @$("[data-validation=#{attr}]").parent()
      .removeClass('has-error')
      .addClass('has-success')

  invalid: (view, attr, error, selector) =>
    @failure(@model)
    @$("[data-validation=#{attr}]").parent()
      .removeClass('has-success')
      .addClass('has-error')

module.exports = BootstrapFormView
