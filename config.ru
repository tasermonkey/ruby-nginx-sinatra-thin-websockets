require 'rubygems'
require 'thin'
require 'sinatra'

require File.expand_path '../app.rb', __FILE__

run MyApp.new
