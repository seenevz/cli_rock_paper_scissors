require_all "lib"
# Screen render take 2 optional args, a params hash with options to box display and prompt, and a custom instance of prompt
# params: { box: "I'm empty", prompt: "I'm lost" }, prompt: @prompt
class Cli
  def initialize
    @screen = InterfaceAdapter.new
    @user = nil
    @reply = nil
    @game = nil
  end

  def menu
    prompt_options = { type: :select, options: { text: "What do you wanna do?", choices: { "Start a new game": 1, "Check out your jokes and slurrs": 2, "Get outta here": 3 } } }
    screen_text = nil

    @reply ? (screen_text = @reply; @reply = nil) : screen_text = "You're still around? There's gotta be something else better for you to do!"
    prompt_reply = @screen.render(params: { box: screen_text, prompt: prompt_options })

    case prompt_reply
    when 1
      start_game
    when 2
      puts "check stuff"
      menu
    when 3
      system "clear"
      puts "Whatever"
    end
  end

  def start_game
    game = Game.new
    game.screen = @screen
    game.play
    game.win ? win_screen : loose_screen
    begin
      game.save
    rescue => exception
      puts exception
    end
    menu
  end

  def win_screen
    screen_text = "Well done, you just beat your dad! And succeeded to hearing him insulting you..."
    prompt_options = { type: :select, options: { text: "Do you really wanna hear your dad insulting you?", choices: { "I have to": true, "Give me a joke instead": false } } }

    prompt_reply = @screen.render(params: { box: screen_text, prompt: prompt_options })
    prompt_reply ? render_slur : render_joke
  end

  def loose_screen
    screen_text = "And as if loosing wasn't enough, you still have to listen to him telling one of his jokes!"
    prompt_options = { type: :keypress, options: { text: "Press any key to hear the joke" } }

    @screen.render(params: { box: screen_text, prompt: prompt_options })
    render_joke
  end

  def render_joke
    quote = @user.quotes.new
    quote.get_joke
    quote.save
    @reply = quote.text
  end

  def render_slur
    quote = @user.quotes.new
    quote.get_insult
    quote.save
    @reply = quote.text
  end

  def user_auth
    prompt_options = { type: :ask, options: { text: "What was your name again?" } }
    screen_text = "Hey! You're here! I reckon you fancy spend time with your dad..."

    reply = @screen.render(params: { box: screen_text, prompt: prompt_options })
    @user = User.find_or_create_by(name: reply.downcase)
  end

  def start
    if @user == nil then user_auth end
    menu
  end
end
