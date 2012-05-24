# Load the file
lines = File.readlines(ARGV[0])
text = lines.join

# Get the unique boundary code
code = text.scan(/^--(.+)(\n)(Content-Type: text\/plain)/).join
boundary = '--' + code.gsub(/\nContent-Type: text\/plain/, "")

# Parse the direction information
date = "Date: " + text.scan(/(?<=^Date: )(.+)(\n)/).join.to_s
to = "To: " + text.scan(/(?<=^To: )(.+)(\n)/).join.to_s
from = "From: " + text.scan(/(?<=^From: )(.+)(\n)/).join.to_s
cc = "Cc: " + text.scan(/(?<=^Cc: )(.+)(\n)/).join.to_s
bcc = "Bcc: " + text.scan(/(?<=^Bcc: )(.+)(\n)/).join.to_s

# Split the sections by the boundary and get relevant/readable
sections = text.split(boundary)
content = sections[1].gsub(/(^C)(.+)/, "").strip.chomp('--')

# Format
puts "\n"
puts "----------------------------------"
puts "\n"
puts date
puts from
puts to
puts cc
puts bcc
puts "\n"
puts "----------------------------------"
puts "\n"
puts content
