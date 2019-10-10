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
      return {boolean: cpu_choice == "paper" ? false : true, cpu_hand: cpu_choice }
    when "paper"
      return {boolean: cpu_choice == "scissors" ? false : true, cpu_hand: cpu_choice }
    when "scissors"
      return {boolean: cpu_choice == "rock" ? false : true, cpu_hand: cpu_choice }
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
    result
  end

  def play_round(screen_text:)
    @player_choice = @screen.render(params: { box: screen_text, prompt: @prompt_options })

    reply = {cpu_hand: self.determine_round}
    reply
  end

  def between_round_screen(result)
    @screen.render(params: {box: 'smth', prompt: {type: :empty}})
    sleep 1.5
  end

  def round_one
    screen_text = "It's time for you to face your dad!"

    result = play_round(screen_text: screen_text)
    between_round_screen(result)
  end

  def round_two
    screen_text = @state[:round_1] ? "Round 2 ! Ready to finish him off?" : "Round 2... Nothing's lost yet!"

    play_round(screen_text: screen_text)
  end

  def round_three
    screen_text = @state[:round_2] ? "Round 3! Grab that glory!" : "Round 3! Don't let your dad steal this from you!"

    play_round(screen_text: screen_text)
    self.winner ? self.win = true : self.win = false
  end

  def play
    round_one
    round_two
    if self.winner != nil
      self.winner ? self.win = true : self.win = false
    else
      round_three
    end
  end
end
