class InterfaceAdapter
  def initialize
    @height = TTY::Screen.height
    @width = TTY::Screen.width
    @cursor = TTY::Cursor
    @prompt = TTY::Prompt.new
  end

  def display_prompt(prompt_inst:, params:)
    print @cursor.down(10)
    case params[:type]
    when :ask
      prompt_inst.ask(params[:options])
    when :select
      display_prompt.select(params[:options])
    else
      print "I have nothing to say!"
    end
  end

  def display_box(text)
    system "clear"
    print TTY::Box.frame(
      width: (@width),
      height: ((@height) / 2),
      align: :center,
    ) do
      text || "I'm feeling tired, maybe we should stop"
    end
  end

  def render(params: { box: "I'm empty", prompt: "I'm lost" }, prompt: @prompt)
    display_box(params[:box])
    display_prompt(prompt_inst: prompt, params: params[:prompt])
  end
end
