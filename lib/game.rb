class Game < ActiveRecord::Base
  belongs_to :user

  def draw(choice)
    cpu_choice = ["rock", "paper", "scissors"].sample

    case choice
    when "rock"
      cpu_choice == "paper" ? false : true
    when "paper"
      cpu_choice == "scissors" ? false : true
    when "scissors"
      cpu_choice == "rock" ? false : true
    end
  end
end
