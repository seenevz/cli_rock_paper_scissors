require_all "lib"
# Screen render take 2 optional args, a params hash with options to box display and prompt, and a custom instance of prompt
# params: { box: "I'm empty", prompt: "I'm lost" }, prompt: @prompt
screen = InterfaceAdapter.new

def menu(screen)
  game = Game.new
  game.screen = screen
  game.play
end

menu(screen)
binding.pry
0
