require_all "lib"

inner_box = lambda { |params|
  TTY::Box.frame(
    width: (TTY::Screen.width) - 2,
    height: ((TTY::Screen.height) / 2) - 2,
    align: :center,
    # padding: 1,
  ) do
    binding.pry
    "Drawing a box in terminal emulator"
  end
}

inner_box_2 = lambda { |params|
  TTY::Box.frame(
    width: (TTY::Screen.width) - 2,
    height: ((TTY::Screen.height) / 2) - 2,
    align: :center,
    # padding: 1,
  ) do
    "Drawing a box in terminal emulator again"
  end
}

screen_box = lambda { |params|
  TTY::Box.frame(
    width: (TTY::Screen.width),
    height: (TTY::Screen.height),
    align: :center,
  ) do
    binding.pry
    "#{inner_box.call({ param1: "stuff" })}#{inner_box_2.call}"
  end
}

puts screen_box
# print "\n" * 5

# box_2 = lambda {
#   TTY::Box.frame(
#     top: 3,
#     left: 25,
#     width: 15,
#     height: 5,
#     border: {
#       type: :thick,
#       top_left: :divider_down,
#       bottom_left: :divider_up,
#     },
#     align: :center,
#     padding: [1, 2],
#     style: {
#       bg: :red,
#       border: {
#         bg: :red,
#       },
#     },
#   ) { "Inside of 2" }
# }

# box_1 = TTY::Box.frame(
#   top: 3,
#   left: 10,
#   width: 15,
#   height: 5,
#   border: {
#     type: :thick,
#     right: false,
#   },
#   align: :center,
#   padding: [1, 2],
#   style: {
#     bg: :red,
#     border: {
#       bg: :red,
#     },
#   },
# ) { "#{print box_2.call}" }

# puts box_1
