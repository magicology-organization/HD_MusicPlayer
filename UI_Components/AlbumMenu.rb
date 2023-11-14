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

  

end
