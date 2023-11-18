require 'gosu'
require './Core_programs/Drawing.rb'
require './Core_programs/Shape.rb'
# module ZOrder
#   TEXT = 1
# end

class TestWindow < Gosu::Window
  def initialize()
    super(800, 800, false)
    self.caption = "State"
    @stateMenu = Drawing.new(Gosu::Color::RED, Gosu::Color::BLUE)
    @stateAlbum = Drawing.new(Gosu::Color::BLUE, Gosu::Color::RED)
    @stateMenu.functionButton.selected = true
  end
  def draw()
    if(@stateAlbum.functionButton.selected)
      @stateAlbum.draw()
    else
      @stateMenu.draw()
    end
  end
  def update()
    if (Gosu.button_down?(Gosu::MsLeft) && @stateAlbum.functionButton.selected)
      @stateAlbum.functionButton.selected = !@stateAlbum.functionButton.IsAt(mouse_x, mouse_y)
      @stateMenu.functionButton.selected = @stateMenu.functionButton.IsAt(mouse_x, mouse_y)
    elsif (Gosu.button_down?(Gosu::MsLeft) && @stateMenu.functionButton.selected)
      @stateAlbum.functionButton.selected = @stateAlbum.functionButton.IsAt(mouse_x, mouse_y)
      @stateMenu.functionButton.selected = !@stateMenu.functionButton.IsAt(mouse_x, mouse_y)
    end
  end
end

test = TestWindow.new
test.show
