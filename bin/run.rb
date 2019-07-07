require_relative "../config/environment.rb"

def reload
  load "run.rb"
end

cli = Cli.new

cli.start
# binding.pry
# print "you jumped pry"
