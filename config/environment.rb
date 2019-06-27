require "require_all"
require "http"
require "json"
require "pry"
require 'bundler'
Bundler.require

require_relative '../lib/cli.rb'
require_all 'dev'

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "db/development.db")

Pry.start
