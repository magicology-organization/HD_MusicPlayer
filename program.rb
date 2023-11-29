require 'gosu'
require './UI_Components/MsMenu.rb'
require './UI_Components/AlbumMenu.rb'


class TestWindow < Gosu::Window
  def initialize()
    super(1920, 1080, false)
    self.caption = "Song Player"
    # @font = Gosu::Font.new(80)
    @albumMenu = AlbumMenu.new("./Albums")
    @msMenu = MsMenu.new("./Albums/AOT")
    @arrayMenu = Array.new([@albumMenu, @msMenu])
    @albumMenu.functionButton.selected = true
  end

  def draw()
    bg = Gosu::Image.new("asserts/images/bg.jpg")
    bg.draw(0, 0)
    @arrayMenu.each do |menu|
      if(menu.functionButton.selected)
        menu.draw()
      end
    end
    if(@msMenu.functionButton.selected)
      @msMenu.playSelectedSongs
    end
  end

  def update()
    if (Gosu.button_down?(Gosu::MsLeft) && @albumMenu.functionButton.selected)
      #Album to Msmenu (Invisible Buttons; needs to change)
      flag = @albumMenu.selected(mouse_x, mouse_y)
      @albumMenu.functionButton.selected = !flag
      if(flag)
        @msMenu.initMenu(@albumMenu.printSelectedSong())
        @msMenu.functionButton.selected = true
      end

    elsif (Gosu.button_down?(Gosu::MsLeft) && @msMenu.functionButton.selected)
      #MsMenu to Album Menu (no need changes)
      @msMenu.selected(mouse_x, mouse_y)
      @albumMenu.functionButton.selected = @msMenu.functionButton.IsAt(mouse_x, mouse_y)
      @msMenu.functionButton.selected = !@msMenu.functionButton.IsAt(mouse_x, mouse_y)
    end

  end
end

test = TestWindow.new
test.show
