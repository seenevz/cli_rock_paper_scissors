require "bundler"

Bundler.require

require_all "dev"
require_relative "../lib/cli.rb"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "db/development.db")
