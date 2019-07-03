require_all "lib"

#system "clear"

# inner_box = lambda { |params|
#   TTY::Box.frame(
#     width: (TTY::Screen.width) - 2,
#     height: ((TTY::Screen.height) / 2) - 2,
#     align: :center,
#     # padding: 1,
#   ) do
#     "Drawing a box in terminal emulator"
#   end
# }

# inner_box_2 = lambda { |params|
#   TTY::Box.frame(
#     width: (TTY::Screen.width) - 2,
#     height: ((TTY::Screen.height) / 2) - 2,
#     align: :center,
#     # padding: 1,
#   ) do
#     params || ""
#   end
# }

# screen_box = lambda { |params|
#   system "clear"

#   TTY::Box.frame(
#     width: (TTY::Screen.width),
#     height: (TTY::Screen.height),
#     align: :center,
#   ) do
#     "#{inner_box.call({ param1: "stuff" })}#{inner_box_2.call(params)}"
#   end
# }

# prompt = TTY::Prompt.new
# print screen_box.call('')
# response = prompt.ask("some stuff here")
# print screen_box.call(response)

############ UI CLI Gem ######################
system "clear"
CLI::UI::StdoutRouter.enable #CLI/UI output router

CLI::UI::Frame.open("Frame 1", timing: nil) do
  # CLI::UI::Frame.open("Frame 2") { puts "inside frame 2" }
  # puts "inside frame 1"
  48.times { puts "" }
end
# CLI::UI::Frame.open("Frame 1") do
#   CLI::UI::Frame.open("Frame 2") { CLI::UI::Prompt.ask("whaaa??") { |handler| handler.option("ttttt") { |sel| sel }; handler.option("yeahhh") { |sel| sel } } }
#   puts "inside frame 1"
# end
