require './Core_programs/Drawing.rb'
require './UI_Components/PlayButton.rb'

class AlbumMenu
  attr_accessor :drawing
  def initialize(path)
    # @drawing = drawing.new
    @buttons = Array.new()
    
  end
  def addUIComponents
    @shape = Shape.new
    @drawing.addShape(shape)
  end
  def playSelectedSongs
    @buttons.each do |btn|
      if(btn.selected)
        @newTrack = btn.click()
      end
    end
  end
  def initmenu()
    button_1 = PlayButton.new()
    button_2 = PlayButton.new(0 , 100, 60, 60, Gosu::Color::GREEN, 'Ashes on The Fire.mp3')
    @buttons << button_1
    @buttons << button_2
  end
  

end
