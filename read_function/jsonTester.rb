require 'json'

# Specify the path to your JSON file
json_file_path = './Albums/AOT/metadata.json'

# Read the JSON file
json_data = File.read(json_file_path)

# Parse the JSON data
parsed_data = JSON.parse(json_data)

# Print each line
puts "Genre: #{parsed_data['genre']}"
puts "Author: #{parsed_data['author']}"
puts "Published: #{parsed_data['published']}"
