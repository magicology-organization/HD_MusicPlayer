def formatAlbumName(name)
  name.gsub(/(?<!\A)(?=[A-Z])/, ' ')
end
