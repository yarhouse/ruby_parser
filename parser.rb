# Load the file
lines = File.readlines(ARGV[0])
text = lines.join

# Get the unique boundary code
code = text.scan(/^--(.+)(\n)(Content-Type: text\/plain)/).join
boundary = '--' + code.gsub(/\nContent-Type: text\/plain/, "")

# Split the sections by the boundary and get relevant/readable
sections = text.split(boundary)
header = sections[0].gsub(/\n\s+/, " ")
content = sections[1].gsub(/(^C)(.+)/, "").strip.chomp('--')

# Parse the head information
date = header.scan(/(^Date: )(.+)(\n)/).join.to_s
to = header.scan(/(^To: )(.+)(\n)/).join.to_s
from = header.scan(/(^From: )(.+)(\n)/).join.to_s
cc = header.scan(/(^Cc: )(.+)(\n)/).join.to_s
bcc = header.scan(/(^Bcc: )(.+)(\n)/).join.to_s
subject = header.scan(/(^Subject: )(.+)(\n)/).join.to_s
top = date + from + to + cc + bcc + subject

# Format
puts "\n"
puts "__________________________________"
puts "\n"
puts top
puts "\n"
puts "__________________________________"
puts "\n"
puts content
puts "\n"
puts "__________________________________"