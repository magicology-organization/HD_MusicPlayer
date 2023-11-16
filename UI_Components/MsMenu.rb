require "gosu"
require './UI_Components/PlayButton.rb'

class MsMenu
  attr_writer :color
  def initialize(album)
    @color = Gosu::Color::WHITE
    @buttons = Array.new()
    @newTrack
    @currentTrack
    initMenu(album)
  end

  def initMenu(album)
    trackNames = print_music_names("./Albums/#{album}")
    currentXPos = 0;
    trackNames.each do |track|
      btn = PlayButton.new(currentXPos, 0, 50, 50, Gosu::Color::BLUE, "#{album}/#{track}")
      @buttons << btn
      currentXPos += 80
    end
  end

  def draw()
    Gosu.draw_rect(0, 0, 800, 800, @color)
    @buttons.each do |btn|
      btn.draw()
    end
  end
  def selected(mouse_x, mouse_y)
    @buttons.each do |btn|
      btn.selected = btn.IsAt(mouse_x, mouse_y)
    end
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
end
