require '../parser/lib/parse.rb'

# Load the file
lines = File.readlines(ARGV[0])
text = lines.join

# Array of header info wanted from email, in order
wants = ["date", "to", "from", "cc", "bcc", "subject" ]

email = Parse.new(text, wants)

puts email.parse_email