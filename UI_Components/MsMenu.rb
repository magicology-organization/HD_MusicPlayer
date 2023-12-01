require "gosu"
require './UI_Components/buttons/SongButton.rb'
require 'json'

#Changes including:
# Use songBtn instead of PlayButton
# UI changed: Adding texts
# UI changed: Adding album covers

module ZOrder
  TEXT = 1
end
class MsMenu
  attr_writer :color
  attr_accessor :functionButton
  def initialize(album)
    @color = Gosu::Color::GREEN
    @newTrack
    @currentTrack
    initMenu(album)
    @functionButton = Shape.new(13, 13, 55, 55, Gosu::Color::FUCHSIA)
    @font = Gosu::Font.new(80)
    @subfont = Gosu::Font.new(60)
  end

  def initMenu(album)
    @buttons = Array.new()
    trackNames = print_music_names("#{album}")
    puts "#{album}"
    @albumData = readMetadata("#{album}")
    currentYPos = 80;
    trackNames.each do |track|
      btn = SongButton.new(200, currentYPos, 1100, 80, Gosu::Color.argb(100, 102, 255, 51), "#{album}/#{track}")
      @buttons << btn
      currentYPos += 150
    end
  end

  def draw()
    # Gosu.draw_rect(0, 0, 1920, 1080, @color)
    @buttons.each do |btn|
      btn.draw()
    end
    @functionButton.draw()
    bg = Gosu::Image.new(@albumData['img'])
    @font.draw_text(@albumData['altname'], 1400, 10, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    bg.draw(1400, 100, 1, 1.67, 1.67)
    # bg.draw(1400, 20)
  end
  def selected(mouse_x, mouse_y)
    flag = false
    @buttons.each do |btn|
      btn.selected = btn.IsAt(mouse_x, mouse_y)
      if(btn.IsAt(mouse_x, mouse_y))
        flag = true
      end
    end
    return flag
  end
  def playSelectedSongs
    @buttons.each do |btn|
      if(btn.selected)
        @newTrack = btn.emit_song()
      end
    end
    if(@newTrack != @currentTrack)
      @song = Gosu::Song.new(@newTrack)
      @currentTrack = @newTrack
      @song.play
    end
  end

  def print_music_names(directory)
    # Check if the provided directory exists
    unless Dir.exist?(directory)
      puts "Error: Directory does not exist."
      return
    end
    # Get an array of all entries (files and directories) in the specified directory
    entries = Dir.entries(directory)
    # Filter out "." and ".." (current and parent directory) and select only .mp3 files
    music_files = entries.select do |entry|
      File.file?(File.join(directory, entry)) && entry.end_with?(".mp3")
    end
    # Print the names of music files
    puts "Music files in '#{directory}':"
    music_files.each { |music_file| puts music_file }
    return music_files
  end

  def readMetadata(directory)
    # Specify the path to your JSON file
    json_file_path = "#{directory}/metadata.json"
    puts json_file_path
    # Read the JSON file
    json_data = File.read(json_file_path)
    # Parse the JSON data
    parsed_data = JSON.parse(json_data)
    return parsed_data
  end
end
