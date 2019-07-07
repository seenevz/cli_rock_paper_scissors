class Game < ActiveRecord::Base
  belongs_to :user

  attr_reader :winner, :state
  attr_writer :player_choice, :screen

  after_initialize { |game|
    @state = { 'round_1': nil, "round_2": nil, "round_3": nil, 'current_round': 1 }
    @winner = nil
    @player_choice = nil
    @screen = nil
    @prompt_options = { type: :select, options: { text: "Select your fist:", choices: %w(Rock Paper Scissors) } }
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

  def determine_round
    result = draw(@player_choice)
    @state["round_#{@state[:current_round].to_s}".to_sym] = result
    find_winner
    @state[:current_round] += 1
  end

  def play_round(screen_text:)
    player_answer = @screen.render(params: { box: screen_text, prompt: @prompt_options })
    @player_choice = player_answer

    reply = self.determine_round
    reply
  end

  def round_one
    screen_text = "It's time for you to face your dad!"

    play_round(screen_text: screen_text)
  end

  def round_two
    screen_text = @state[:round_1] ? "Round 2 ! Ready to finish him off?" : "Round 2... Nothing's lost yet!"

    play_round(screen_text: screen_text)
  end

  def round_three
    screen_text = @state[:round_2] ? "Round 3! Grab that glory!" : "Round 3! Don't let your dad steal this from you!"

    play_round(screen_text: screen_text)
    self.winner ? self.win_screen : self.loose_screen
  end

  def win_screen
    screen_text = "Well done, you just beat your dad! And succeeded to hearing him insulting you..."
    prompt_options = { type: :select, options: { text: "Do you really wanna hear your dad insulting you?", choices: ["I have to", "Give me a joke instead"] } }
    self.win = true
    @screen.render(params: { box: screen_text, prompt: prompt_options })
  end

  def loose_screen
    screen_text = "And as if loosing wasn't enough, you still have to listen to him telling one of his jokes!"
    prompt_options = { type: :keypress, options: { text: "Press any key to hear the joke" } }
    self.win = false
    @screen.render(params: { box: screen_text, prompt: prompt_options })
  end

  def play
    round_one
    round_two
    if self.winner != nil
      self.winner ? self.win_screen : self.loose_screen
    else
      round_three
    end
  end
end
