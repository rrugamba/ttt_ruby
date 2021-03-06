require_relative 'play'

module Console

  class Run
    input = Input.new
    collect = Collect.new
    display = ConsoleDisplay.new
    play = Play.new(input, collect, display)
    play.set_up
  end
end