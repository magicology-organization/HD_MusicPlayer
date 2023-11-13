require 'gosu'
require './drawing.rb'
require './shape.rb'

class MusicPlayer < Gosu::Window
    def initialize
        super(700, 700, false)
        self.caption = "Music player"
        @wd = Shape.new(0, 0, 230, 230, Gosu::Color::BLUE)
    end
    def draw
        @wd.draw()
    end
    def update
        if Gosu.button_down?(Gosu::MsLeft)
            @wd.selected(mouse_x, mouse_y)
        end
    end
end


window = MusicPlayer.new()
window.show


    