#Adding Copmponents
require './Core_programs/Shape.rb'
require 'gosu'

module ZOrder
    TEXT = 1
end
class SongButton < Shape
    def initialize(x = 0, y = 0, width = 40, height = 40, color = Gosu::Color::RED, music_path = '')
        @x = x
        @y = y
        @width = width
        @height = height
        @color = color
        @selected = false
        @song_path = music_path
        @font = Gosu::Font.new(55)
    end
    def draw()
        if (@selected)
            draw_outline()
            @font.draw_text("► #{extract_file_name(@song_path)}", 1400, 590, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
        end
        Gosu.draw_rect(@x, @y, @width, @height, @color)
        @font.draw_text(extract_file_name(@song_path), @x+10, @y+10, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    end
    def emit_song()
        return "#{@song_path}"
    end
    def extract_file_name(path)
        return formatSongName(File.basename(path, '.*'))
    end
    def formatSongName(name)
        formattedName = name.gsub(/(?<!\A)(?=[A-Z])/, ' ')
        return formattedName
    end
end
