require 'gosu'
require './Core_programs/Drawing.rb'
require './Core_programs/Shape.rb'

class MusicPlayer < Gosu::Window
    def initialize
        super(1920, 1080, false)
        self.caption = "Music player"
        @drawing = Gosu::Image.new("asserts/images/bg.jpg")
    end
    def draw
        @drawing.draw(0, 0, 0, 0.5, 0.5, Gosu::Color::WHITE)
    end
    def update

    end
end


window = MusicPlayer.new()
window.show


