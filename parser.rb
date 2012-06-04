require '/home/aaron/ruby/parser/classes.rb'

# Load the file
lines = File.readlines(ARGV[0])
text = lines.join

# Array of the info you want from the email head
$wants = ["date", "to", "from", "cc", "bcc", "subject", ]

email = Parse.new

puts
email.parse_it(text)
puts