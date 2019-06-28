require_all "lib"

@outer_box = lambda {
  TTY::Box.frame(
    width: (TTY::Screen.width),
    height: ((TTY::Screen.height) / 2),
    align: :center,
    padding: 1,
  ) do
    "Drawing a box in terminal emulator"
  end
}

def screen_box(box1)
  TTY::Box.frame(
    width: (TTY::Screen.width),
    height: (TTY::Screen.height),
    align: :center,
    padding: 3,
  ) do
    binding.pry
    print box1.call
  end
end
