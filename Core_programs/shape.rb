require 'Gosu'

class Shape
    attr_writer :color, :height, :width
    attr_accessor :selected, :x, :y
    def initialize( x 50, y = 50, width = 80, height = 90, color = Gosu::Color::RED)
        @color = color 
        @height = height
        @width = width
        @x = x 
        @y = y  
        @selected = false 
    end
    def draw()
        if @selected
            draw_outline()    #or hover button
        end
        Gosu.draw_rect(@x, @y, @height, @width, @color) 
    end
    def draw_outline()
        Gosu.draw_rect(@x - 2, @y - 2, @width + 4, @height + 4, Gosu::Color::WHITE)
    end
    def IsAt(pointX, pointY)
        return (pointX >= @x && pointX <= @x + @width && pointY >= @y && pointY <= @y + @height)
    end
end
