require '/home/aaron/ruby/parser/version2_classes.rb'

lines = File.readlines(ARGV[0])
text = lines.join
wants = ["date", "to", "from", "cc", "bcc", "subject", ]
email = Parse.new
email.break_body(text)

puts
email.parse_head(wants)
email.put_content
puts