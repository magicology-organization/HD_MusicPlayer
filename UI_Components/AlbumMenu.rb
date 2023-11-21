require "gosu"
require './UI_Components/PlayButton.rb'
require './UI_Components/MsMenu.rb'

class AlbumMenu < MsMenu
  def initialize(albumPath)
    @color = Gosu::Color::WHITE
    @buttons = Array.new()
    initMenu(albumPath)
    @functionButton = Shape.new(0, 0, 100, 100, Gosu::Color::RED)
  end
  def initMenu(albumPath)
    trackNames = print_folder_names(albumPath)
    currentXPos = 80;
    trackNames.each do |track|
      btn = PlayButton.new(currentXPos, 80, 50, 50, Gosu::Color::BLUE, "#{albumPath}/#{track}")
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
  def print_folder_names(directory)
    entries = Dir.entries(directory)
    folders = entries.select { |entry| File.directory?(File.join(directory, entry)) && entry != "." && entry != ".." }
    puts "Folder names in '#{directory}':"
    folders.each do |folder|
      puts "found:#{folder}!"
    end
  end
  def printSelectedSong
    @buttons.each do |btn|
      if(btn.selected)
        puts(btn.emit_song())
      end
    end
  end
end
