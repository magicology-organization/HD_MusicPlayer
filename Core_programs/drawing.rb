require 'Gosu'

class Drawing
    aatr_writer :color 
    def initialize( color = Gosu::Color::Black)
        @color = color 
        @shapes = Array.new()    #later be used for adding album images
        @buttons = Array.new()  
    end
    def newShape(shape)
        @shapes << shape
    end
    def newButton(button)
        @buttons << button
    end
    def draw()
        @shapes.each do |shape|
            shape.draw()
        end
    end
    def button()   
        @buttons.each do |buttons|
            buttons.draw()
        end
    end
    def selectedShape(mouse_x, mouse_y)
        @shapes.each do |shape|
            shape.selectedShape = shape.IsAt(mouse_x, mouse_y)
        end
    end
    def selectedButton(mouse_x, mouse_y)
        @buttons.each do |button|
            buttons.selectedButton = shape.IsAt(mouse_x, mouse_y)
        end
    end
end


# button -> play/pause/next button
# shape -> album