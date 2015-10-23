path = require 'path'
webpack = require 'webpack'

ChunkManifestPlugin = require 'chunk-manifest-webpack-plugin'
module.exports =
  entry:
    app: './coffee/ittok/application.coffee'
    #vendor: [
    #  'bootstrap'
    #  'rangy'
    #  'jquery'
    #  'jquery-ui'
    #  'marionette'
    #  'teacup'
    #  ]
    #halloeditor: [
    #  "hallo/src/hallo"
    #  "hallo/src/widgets/dropdownbutton"
    #  "hallo/src/widgets/button"
    #  "hallo/src/toolbar/contextual"
    #  "hallo/src/plugins/halloformat"
    #  "hallo/src/plugins/headings"
    #  "hallo/src/plugins/justify"
    #  "hallo/src/plugins/link"
    #  "hallo/src/plugins/lists"
    #  "hallo/src/plugins/reundo"
    #  "hallo/src/plugins/image_insert_edit"
    #  "hallo/src/plugins/image"
    #  "hallo/src/plugins/image/current"
    #  "hallo/src/plugins/block"
    #  "hallo/src/plugins/blacklist"
    #  ]
  output:
    path: path.join __dirname, "ittok/static"
    publicPath: '/static/'
    filename: 'app.js'
      
  plugins: [
    new webpack.optimize.DedupePlugin()
    #new webpack.optimize.CommonsChunkPlugin
    #  name: 'vendor'
    #  filename: 'vendor.js'
    #new ChunkManifestPlugin
    #  #path: path.join __dirname, "ittok/static"
    #  #publicPath: '/static/'
    #  filename: 'manifest.json'
    #  manifestVariable: 'webpackManifest'
      
    #new webpack.optimize.UglifyJsPlugin
    #  minimize: true
    ]
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
        test: require.resolve 'rangy'
        loader: "expose?rangy"
      }
      {
        test: /jquery\/src\/selector\.js$/
        loader: 'amd-define-factory-patcher-loader'
      }
      ]
  resolve:
    fallback: [
      path.join __dirname, 'coffee/ittok'
      ]
    alias:
      jquery: 'jquery/src/jquery'
      #'jquery-ui': ''
      #'backbone.marionette': 'backbone.marionette/lib/core/backbone.marionette'
      #'marionette': 'backbone.marionette/lib/core/backbone.marionette'
      #marionette: 'backbone.marionette'
      'bootstrap-fileinput-css': 'bootstrap-fileinput/css/fileinput.min.css'
      'bootstrap-fileinput-js': 'bootstrap-fileinput/js/fileinput.min.js'
      tablednd: 'TableDnD/js/jquery.tablednd.js'
      request: 'browser-request'
      #'vie': 'vie/src/VIE'
      #hallomain: 'hallo/src/hallo'
      #'hallo/plugins': 'hallo/src/plugins'
      
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
      new webpack.ResolverPlugin
        new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin
          "bower.json", ["main"]
        ['normal', 'loader']
      #new webpack.optimize.OccurenceOrderPlugin true
    ]

