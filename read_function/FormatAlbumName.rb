def formatAlbumName(name)
  name.gsub(/(?<!\A)(?=[A-Z])/, ' ')
end

spacer = formatAlbumName("HelloWorldWithoutSpace")
puts spacer
