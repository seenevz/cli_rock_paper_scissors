require_all "lib"
# Screen render take 2 optional args, a params hash with options to box display and prompt, and a custom instance of prompt
# params: { box: "I'm empty", prompt: "I'm lost" }, prompt: @prompt
class Cli
  def initialize
    @screen = InterfaceAdapter.new
  end

  def menu
    prompt_options = { type: :select, options: { text: "Where do you wanna go?", choices: { "Start a new game": 1, "Check out your jokes and slurrs": 2, "Get outta here": 3 } } }
    screen_text = "Hey! You're here! I reckon you fancy spend time with your dad..."
    reply = @screen.render(params: { box: screen_text, prompt: prompt_options })

    case reply
    when 1
      start_game
    when 2
      puts "check stuff"
      menu
    when 3
      puts "dunno yet"
    end
  end

  def start_game
    game = Game.new
    game.screen = @screen
    game.play
    begin
      game.save
    rescue => exception
      puts exception
    end
    menu
  end

  def start
    menu
  end
end
