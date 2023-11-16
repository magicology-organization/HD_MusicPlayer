require 'gosu'
require './UI_Components/MsMenu.rb'

# module ZOrder
#   TEXT = 1
# end

class TestWindow < Gosu::Window
  def initialize()
    super(800, 800, false)
    self.caption = "Song Player"
    # @font = Gosu::Font.new(80)
    @menu = MsMenu.new("AOT")
  end
  def draw()
    @menu.draw()
    @menu.playSelectedSongs
  end
  def update()
    if Gosu.button_down?(Gosu::MsLeft)
      @menu.selected(mouse_x, mouse_y)
    end
  end
end

test = TestWindow.new
test.show
