path = require 'path'
webpack = require 'webpack'

module.exports =
  entry: './coffee/ittok/application.coffee'
  output:
    filename: 'ittok/static/bundle.js'
  module:
    loaders: [
      {
        test: /\.coffee$/
        loader: 'coffee'
      }
      {
        test: /\.css$/
        loader: 'style!css'
      }
      {
        test: /\.(gif|png|eot|ttf)?$/
        loader: 'url-loader'
      }
      {
        test: /\.(woff|woff2|eot|ttf)(\?[\&0-9]+)?$/
        loader: 'url-loader'
      }
      {
        test: /\.(woff|woff2|eot|ttf)(\?v=[0-9]\.[0-9]\.[0-9])?$/
        loader: 'url-loader'
      }
      # This is for using packaged jquery
      #{
      #  test: require.resolve 'jquery'
      #  loader: "expose?$!expose?jQuery"
      #}
      {
        test: /jquery\/src\/selector\.js$/
        #loader: "expose?$!expose?jQuery"
        loader: 'amd-define-factory-patcher-loader'
      }
      ]
  resolve:
    fallback: [
      path.join __dirname, 'coffee/ittok'
      ]
    alias:
      jquery: 'jquery/src/jquery'
      #marionette: 'backbone.marionette/lib/core/backbone.marionette'
      marionette: 'backbone.marionette'
      'bootstrap-fileinput-css': 'bootstrap-fileinput/css/fileinput.min.css'
      'bootstrap-fileinput-js': 'bootstrap-fileinput/js/fileinput.min.js'
      tablednd: 'TableDnD/js/jquery.tablednd.js'
    modulesDirectories: [
      'node_modules'
      'bower_components'
      ]
    extensions: [
      # MUST include empty string
      # https://webpack.github.io/docs/configuration.html#resolve-extensions
      ''
      '.webpack.js'
      '.web.js'
      '.js'
      # add coffescript files to the list
      '.coffee'
    ]
    plugins: [
      #new webpack.ProvidePlugin
      #  '$': 'jquery'
      #  'jQuery': 'jquery'
      #  'window.jQuery': 'jquery'
        
      new webpack.ResolverPlugin(
        new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
    )
    ]

