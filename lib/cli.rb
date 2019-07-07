require_all "lib"
# Screen render take 2 optional args, a params hash with options to box display and prompt, and a custom instance of prompt
# params: { box: "I'm empty", prompt: "I'm lost" }, prompt: @prompt
class Cli
  def initialize
    @screen = InterfaceAdapter.new
  end

  def menu(screen)
    game = Game.new
    game.screen = @screen
    game.play
  end

  def start
    menu
  end
end
