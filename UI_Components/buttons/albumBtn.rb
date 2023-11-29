require './UI_Components/PlayButton.rb'

module ZOrder
  TEXT = 1
end

class AlbumButton
    def initialize

      initFunc()
    end
    def initFunc

    end
    def formatAlbumName(name)
      name.gsub(/(?<!\A)(?=[A-Z])/, ' ')
    end
    def get_last_directory(path)
      # Split the path using the directory separator (assuming '/' for Unix-like systems)
      directories = path.split('/')

      # Get the last element (directory) from the array
      last_directory = directories.last

      # Return the last directory
      return last_directory
    end
end
