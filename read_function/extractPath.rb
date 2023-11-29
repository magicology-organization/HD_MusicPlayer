def get_last_directory(path)
  # Split the path using the directory separator (assuming '/' for Unix-like systems)
  directories = path.split('/')

  # Get the last element (directory) from the array
  last_directory = directories.last

  # Return the last directory
  return last_directory
end

# Example usage:
input_path = "folder/folder1/folder2/name"
output = get_last_directory(input_path)
puts output
