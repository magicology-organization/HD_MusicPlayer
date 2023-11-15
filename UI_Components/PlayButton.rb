require './Core_programs/Shape.rb'
require 'gosu'
class PlayButton < Shape
    def initialize(x = 0, y = 0, width = 40, height = 40, color = Gosu::Color::RED, music_path = '')
        @x = x
        @y = y
        @width = width
        @height = height
        @color = color
        @selected = false
        @song_path = music_path
    end
    def emit_song()
        return "./Albums/#{@song_path}"
    end
end
