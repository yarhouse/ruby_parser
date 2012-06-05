require '/home/aaron/ruby/parser/test_classes.rb'

# Load the file
lines = File.readlines(ARGV[0])
text = lines.join

# Array of the info you want from the email head
wants = ["date", "to", "from", "cc", "bcc", "subject", ]

email = Parse.new(text, wants)

puts email.parse_email