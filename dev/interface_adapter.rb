class InterfaceAdapter
  attr_reader :prompt

  def initialize
    @height = TTY::Screen.height
    @width = TTY::Screen.width
    @cursor = TTY::Cursor
    @prompt = TTY::Prompt.new
  end

  def display_prompt(prompt_inst:, params:)
    reply = nil
    print @cursor.down(7)

    case params[:type]
    when :ask
      reply = prompt_inst.ask(params[:options][:text])
      return reply
    when :select
      reply = prompt_inst.select(params[:options][:text], params[:options][:choices])
      return reply
    when :keypress
      reply = prompt_inst.keypress(params[:options][:text])
    when :yes
      reply = prompt_inst.yes?(params[:options][:text])
    else
      print ""
    end
  end

  def display_box(text)
    system "clear"
    box = TTY::Box.frame(
      width: (@width),
      height: ((@height) / 2),
      align: :center,
      padding: 4,
    ) do
      text || "I'm feeling tired, maybe we should stop..."
    end
    print box
  end

  def render(params: { box: "I'm empty", prompt: { type: :ask, options: "I'm lost!" } }, prompt: @prompt)
    display_box(params[:box])
    display_prompt(prompt_inst: prompt, params: params[:prompt])
  end
end
