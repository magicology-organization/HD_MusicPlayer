require 'Gosu'
require './Core_programs/Shape.rb'

class Drawing
    attr_writer :color
    def initialize( color = Gosu::Color::Black)
        @color = color
        @shapes = Array.new()
    end
    def addShape(shape)
        @shapes << shape
    end
    def draw()
        @shapes.each do |shape|
            shape.draw()
        end
    end
    def select(mouse_x, mouse_y)
        @shapes.each do |shape|
          shape.selected = shape.IsAt(mouse_x, mouse_y)
        end
    end
end
