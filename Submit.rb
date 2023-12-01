require 'json'
require 'gosu'

module ZOrder
  TEXT = 1
end

class Shape
  # attr_writer :color, :height, :width
  attr_accessor :selected, :x, :y
  def initialize( x = 0, y = 0, width = 80, height = 90, color = Gosu::Color::RED)
      @color = color
      @height = height
      @width = width
      @x = x
      @y = y
      @selected = false
  end
  def draw()
      if (@selected)
          draw_outline()
      end
      Gosu.draw_rect(@x, @y, @width, @height, @color)
  end
  def draw_outline()
      Gosu.draw_rect(@x - 2, @y - 2, @width + 4, @height + 4, Gosu::Color::WHITE)
  end
  def IsAt(pointX, pointY)
      return (pointX >= @x && pointX <= @x + @width && pointY >= @y && pointY <= @y + @height)
  end
end
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
    #minus for the back of the album
    @font.draw_text(getAlbumName(@song_path), @x+310, @y+10, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    parsed_data = readMetadata
    @subfont.draw_text("Genre: #{parsed_data['genre']}", @x+310, @y+100, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @subfont.draw_text("Author: #{parsed_data['author']}", @x+310, @y+170, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @subfont.draw_text("Published: #{parsed_data['published']}", @x+310, @y+240, z = ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    #adding image and draw (by using data from JSON)
    bg = Gosu::Image.new(parsed_data['img'])
    #minus for cover and adding 10 as a small spacer
    #Image import can be improved by including the img inside each album file, however since the read file is required
    #so just let it be
    bg.draw(@x + 10, @y + 10)
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
      return "#{@song_path}"
  end
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
class AlbumMenu < MsMenu
  def initialize(albumPath)
    @color = Gosu::Color::GREEN
    @buttons = Array.new()
    initMenu(albumPath)
    @functionButton = Shape.new(0, 0, 100, 100, Gosu::Color::RED)
  end
  def initMenu(albumPath)
    trackNames = print_folder_names(albumPath)
    cnt = 1
    currentXPos = 20
    currentYPos = 70;
    trackNames.each do |track|
      btn = AlbumButton.new(currentXPos, currentYPos, 900 , 300, Gosu::Color.argb(100, 102, 255, 51), "#{albumPath}/#{track}")
      @buttons << btn
      currentXPos += 940
      if(cnt % 2 == 0)
        currentYPos += 340
        currentXPos = 20
      end
      cnt+=1
    end
  end
  def draw()
    # Gosu.draw_rect(0, 0, 1920, 1080, @color)
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
        return btn.emit_song()
      end
    end
  end
end
class TestWindow < Gosu::Window
  def initialize()
    super(1920, 1080, false)
    self.caption = "Song Player"
    # @font = Gosu::Font.new(80)
    @albumMenu = AlbumMenu.new("./Albums")
    @msMenu = MsMenu.new("./Albums/AOT")
    @arrayMenu = Array.new([@albumMenu, @msMenu])
    @albumMenu.functionButton.selected = true
  end

  def draw()
    bg = Gosu::Image.new("asserts/images/bg.jpg")
    bg.draw(0, 0)
    @arrayMenu.each do |menu|
      if(menu.functionButton.selected)
        menu.draw()
      end
    end
    if(@msMenu.functionButton.selected)
      @msMenu.playSelectedSongs
    end
  end

  def update()
    if (Gosu.button_down?(Gosu::MsLeft) && @albumMenu.functionButton.selected)
      #Album to Msmenu (Invisible Buttons; needs to change)
      flag = @albumMenu.selected(mouse_x, mouse_y)
      @albumMenu.functionButton.selected = !flag
      if(flag)
        @msMenu.initMenu(@albumMenu.printSelectedSong())
        @msMenu.functionButton.selected = true
      end

    elsif (Gosu.button_down?(Gosu::MsLeft) && @msMenu.functionButton.selected)
      #MsMenu to Album Menu (no need changes)
      @msMenu.selected(mouse_x, mouse_y)
      @albumMenu.functionButton.selected = @msMenu.functionButton.IsAt(mouse_x, mouse_y)
      @msMenu.functionButton.selected = !@msMenu.functionButton.IsAt(mouse_x, mouse_y)
    end

  end
end

test = TestWindow.new
test.show
