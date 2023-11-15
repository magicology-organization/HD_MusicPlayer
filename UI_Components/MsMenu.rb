require "gosu"
require './UI_Components/PlayButton.rb'

class MsMenu
  attr_writer :color
  def initialize(album)
    @color = Gosu::Color::WHITE
    @buttons = Array.new()
    @album = album
    @newTrack
    @currentTrack
    initMenu
  end

  def initMenu()
    btn1 = PlayButton.new(100, 0, 50, 50, Gosu::Color::BLUE, "#{@album}/PreludeEMinorC.mp3")
    btn2 = PlayButton.new(0, 0, 50, 50, Gosu::Color::BLUE, "#{@album}/VivaldiSummer.mp3")
    @buttons << btn1
    @buttons << btn2
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

end
