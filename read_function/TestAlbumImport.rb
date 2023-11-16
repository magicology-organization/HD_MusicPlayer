#Reference code: import all folders within a larger folder

def print_folder_names(directory)
  entries = Dir.entries(directory)
  folders = entries.select { |entry| File.directory?(File.join(directory, entry)) && entry != "." && entry != ".." }
  puts "Folder names in '#{directory}':"
  folders.each do |folder|
    puts "found:#{folder}!"
  end
end
print_folder_names('../Albums')
