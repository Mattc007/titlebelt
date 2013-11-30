require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'pry'
require './app/titlebelt'

set :environment, :development
set :run, false
set :raise_errors, true

run Sinatra::Application
