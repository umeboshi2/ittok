# inspired by https://github.com/KyleAMathews/coffee-react-quickstart
# 
gulp = require 'gulp'
gutil = require 'gulp-util'

webpack = require 'webpack'

DevServer = require 'webpack-dev-server'
DevConfig = require './webpack.config.coffee'


compass = require 'gulp-compass'
size = require 'gulp-size'

gulp.task 'compass', () ->
  gulp.src('./sass/*.scss')
  .pipe compass
    config_file: './config.rb'
    css: 'ittok/static'
    sass: 'sass'
  .pipe size()
  .pipe gulp.dest 'stylesheets'


# Create a single instance of the compiler to allow caching.
devCompiler = webpack DevConfig
gulp.task 'webpack:build-dev', ['compass'], (callback) ->
  # run webpack
  devCompiler.run (err, stats) ->
    throw new gutil.PluginError('webpack:build-dev', err) if err
    gutil.log "[webpack:build-dev]", stats.toString(colors: true)
    callback()
    return
  return

gulp.task 'coffee', (callback) ->
  # run webpack
  devCompiler.run (err, stats) ->
    throw new gutil.PluginError('webpack:build-dev', err) if err
    gutil.log "[webpack:build-dev]", stats.toString(colors: true)
    callback()
    return
  return
  
gulp.task 'default', ->
  gulp.start 'webpack:build-dev'
  
gulp.task 'watch', ['compass', 'webpack:build-dev'], ->
  gulp.watch ['./sass/**/*.scss', 'config.rb'], ['compass', 'webpack:build-dev']
  gulp.watch ['./coffee/**/*.coffee'], ['webpack:build-dev']
  
