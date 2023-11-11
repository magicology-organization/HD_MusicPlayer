require 'gosu'
require './drawing.rb'
require './shape.rb'

class MusicPlayer < Gosu::Window
    def initialize
        super(900, 900, false)
        self.caption = "Music player"
        @wd = Shape.new(0, 0, 200, 200, Gosu::Color::BLUE)
    end
    def draw()
        @wd.draw()
    end
    def update()
        if Gosu::button_down?(Gosu::MSLeft)
            @wd.selectedShape(mouse_x, mouse_y)
        end
        
    end
end


window = MusicPlayer.new()
window.show()


    