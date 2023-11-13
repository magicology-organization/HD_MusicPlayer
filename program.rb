require 'gosu'
require './Core_programs/Drawing.rb'
require './Core_programs/Shape.rb'

class MusicPlayer < Gosu::Window
    def initialize
        super(700, 700, false)
        self.caption = "Music player"
        @drawing = Drawing.new(Gosu::Color::WHITE)
    end
    def draw
        @drawing.draw()
    end
    def update
        if Gosu.button_down?(Gosu::MsRight)
            shape = Shape.new(mouse_x, mouse_y, 10, 10, Gosu::Color::GREEN)
            @drawing.addShape(shape)
        end
        if Gosu.button_down?(Gosu::MsLeft)
            @drawing.select(mouse_x, mouse_y)
        end
    end
end


window = MusicPlayer.new()
window.show


