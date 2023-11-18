require 'Gosu'
require './Core_programs/Shape.rb'

class Drawing
    attr_writer :color
    attr_accessor :functionButton, :album
    def initialize( color = Gosu::Color::Black, secondColor)
        @color = color
        @shapes = Array.new()
        @functionButton = Shape.new(0, 0, 100, 100, secondColor)
    end
    def addShape(shape)
        @shapes << shape
    end
    def draw()
        Gosu.draw_rect(0, 0, 800, 800, @color)
        @shapes.each do |shape|
            shape.draw()
        end
        @functionButton.draw
    end
    def select(mouse_x, mouse_y)
        @shapes.each do |shape|
          shape.selected = shape.IsAt(mouse_x, mouse_y)
        end
    end
end
