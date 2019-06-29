require_relative "../config/environment.rb"

def reload
  load "run.rb"
end

binding.pry
p "you jumped pry"
