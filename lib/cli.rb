require_all "lib"

cursor_pos = TTY::Cursor
prompt = TTY::Prompt.new
screen = InterfaceAdapter.new
# system "clear"

display_box = lambda { |params|
  TTY::Box.frame(
    width: (TTY::Screen.width),
    height: ((TTY::Screen.height) / 2),
    align: :center,
    # padding: 1,
  ) do
    "Drawing a box in terminal emulator"
  end
}

prompt_box = lambda { |params|
  TTY::Box.frame(
    width: (TTY::Screen.width) - 2,
    height: ((TTY::Screen.height) / 2) - 2,
    align: :center,
    # padding: 1,
  ) do
    # binding.pry
    params || ""
  end
}

# screen_box = lambda { |params|
#   system "clear"

#   TTY::Box.frame(
#     width: (TTY::Screen.width),
#     height: (TTY::Screen.height),
#     align: :center,
#   ) do
#     "#{display_box.call({ param1: "stuff" })}#{prompt_box.call(params)}"
#   end
# }
# print screen_box.call('')
response = lambda { print cursor_pos.down(10); prompt.ask("some stuff here") }
# print screen_box.call("response")
# print display_box.call("stuff")
# response.call()
screen.render(params: {})
