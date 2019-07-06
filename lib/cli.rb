require_all "lib"
# Screen render take 2 optional args, a params hash with options to box display and prompt, and a custom instance of prompt
# params: { box: "I'm empty", prompt: "I'm lost" }, prompt: @prompt
screen = InterfaceAdapter.new
screen_text = nil
prompt_options = { type: :select, options: { text: "Select your fist:", choices: %w(Rock Paper Scissors) } }
game = nil
prompt_answer = nil

# screen.render(params: { box: screen_text, prompt: prompt_options })
def play_round(game:, screen:, screen_text:, prompt_options:)
  player_answer = screen.render(params: { box: screen_text, prompt: prompt_options })
  game.player_choice = player_answer

  reply = game.round
  reply
end

def round_one(screen:, prompt_options:)
  screen_text = "It's time for you to face your dad!"

  game = Game.new
  play_round(game: game, screen: screen, screen_text: screen_text, prompt_options: prompt_options)
  game
end

def round_two(screen:, game:, prompt_options:)
  screen_text = game.state["round_one"] ? "Round 2 ! Ready to finish him off?" : "Round 2... Nothing's lost yet!"

  play_round(screen: screen, screen_text: screen_text, prompt_options: prompt_options, game: game)
  game
end

def round_three(screen:, game:, prompt_options:)
  screen_text = game.state["round_two"] ? "Round 3! Grab that glory!" : "Round 3! Don't let your dad steal this from you!"

  play_round(screen: screen, screen_text: screen_text, prompt_options: prompt_options, game: game)
  game
end

game = round_one(screen: screen, prompt_options: prompt_options)
game = round_two(screen: screen, prompt_options: prompt_options, game: game)
game = round_three(screen: screen, prompt_options: prompt_options, game: game)

binding.pry
0
