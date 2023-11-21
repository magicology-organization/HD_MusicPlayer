require 'gosu'
require './UI_Components/MsMenu.rb'
require './UI_Components/AlbumMenu.rb'

# module ZOrder
#   TEXT = 1
# end

class TestWindow < Gosu::Window
  def initialize()
    super(800, 800, false)
    self.caption = "Song Player"
    # @font = Gosu::Font.new(80)
    @albumMenu = AlbumMenu.new("./Albums")
    @msMenu = MsMenu.new("./Albums/AOT")
    @arrayMenu = Array.new([@albumMenu, @msMenu])
    @albumMenu.functionButton.selected = true
  end
  def draw()
    @arrayMenu.each do |menu|
      if(menu.functionButton.selected)
        menu.draw()
      end
    end
  end
  def update()
    if (Gosu.button_down?(Gosu::MsLeft) && @albumMenu.functionButton.selected)
      @albumMenu.functionButton.selected = !@albumMenu.functionButton.IsAt(mouse_x, mouse_y)
      @msMenu.functionButton.selected = @msMenu.functionButton.IsAt(mouse_x, mouse_y)
    elsif (Gosu.button_down?(Gosu::MsLeft) && @msMenu.functionButton.selected)
      @albumMenu.functionButton.selected = @albumMenu.functionButton.IsAt(mouse_x, mouse_y)
      @msMenu.functionButton.selected = !@msMenu.functionButton.IsAt(mouse_x, mouse_y)
    end
  end
end

test = TestWindow.new
test.show
