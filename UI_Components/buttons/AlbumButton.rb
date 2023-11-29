require './Core_programs/Shape.rb'
require 'gosu'
require 'json'

module ZOrder
    TEXT = 1
end

class AlbumButton < Shape
    def initialize(x = 0, y = 0, width = 40, height = 40, color = Gosu::Color::RED, music_path = '')
        @x = x
        @y = y
        @width = width
        @height = height
        @color = color
        @selected = false
        @song_path = music_path
        @font = Gosu::Font.new(80)
        @subfont = Gosu::Font.new(60)
    end

    def draw()
      if (@selected)
          draw_outline()
      end
      Gosu.draw_rect(@x, @y, @width, @height, @color)
      @font.draw_text(getAlbumName(@song_path), @x+10, @y+10, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
      parsed_data = readMetadata
      @subfont.draw_text("Genre: #{parsed_data['genre']}", @x+10, @y+100, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
      @subfont.draw_text("Author: #{parsed_data['author']}", @x+10, @y+170, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
      @subfont.draw_text("Published: #{parsed_data['published']}", @x+10, @y+240, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    end

    def emit_song()
      return "#{@song_path}"
    end

    def formatAlbumName(name)
      formattedName = name.gsub(/(?<!\A)(?=[A-Z])/, ' ')
      return formattedName
    end
    def getAlbumName(path)
      # Split the path using the directory separator (assuming '/' for Unix-like systems)
      directories = path.split('/')
      # Get the last element (directory) from the array
      last_directory = directories.last
      # Return the last directory
      albumName = formatAlbumName(last_directory)
      return albumName
    end

    def readMetadata()
        # Specify the path to your JSON file
        json_file_path = "#{@song_path}/metadata.json"
        # Read the JSON file
        json_data = File.read(json_file_path)
        # Parse the JSON data
        parsed_data = JSON.parse(json_data)
        return parsed_data
    end
end
