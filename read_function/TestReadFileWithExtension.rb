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
end

# Replace 'your_directory_path' with the path of the directory containing your music files
print_music_names('../Albums/AOT')
