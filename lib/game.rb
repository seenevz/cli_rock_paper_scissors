class Game < ActiveRecord::Base
  belongs_to :user

  attr_reader :winner, :state
  attr_writer :player_choice

  after_initialize { |game|
    @state = { 'round_1': nil, "round_2": nil, "round_3": nil, 'current_round': 1 }
    @winner = nil
    @player_choice = nil
  }

  def draw(choice)
    cpu_choice = ["rock", "paper", "scissors"].sample

    case choice.downcase
    when "rock"
      return cpu_choice == "paper" ? false : true
    when "paper"
      return cpu_choice == "scissors" ? false : true
    when "scissors"
      return cpu_choice == "rock" ? false : true
    end
  end

  def find_winner
    case
    when @state[:round_1] && @state[:round_2]
      @winner = true
    when @state[:current_round] == 2 && !@state[:round_1] && !@state[:round_2]
      @winner = false
    when @state[:current_round] == 3 && @state[:round_3]
      @winner = true
    when @state[:current_round] == 3 && !@state[:round_3]
      @winner = false
    end
  end

  def round
    result = draw(@player_choice)
    @state["round_#{@state[:current_round].to_s}".to_sym] = result
    find_winner
    @state[:current_round] += 1
  end
end
