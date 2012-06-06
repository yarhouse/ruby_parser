class Parse 
	def initialize(text, wants)
		@text = text
		@wants = wants
	end
	def break_body 

		# I opted to go with counting backwards from the plain text content type
		# as I found some emails contain more than one boundary code with multiparts
		code = @text.scan(/^--(.+)(\n)(Content-Type: text\/plain)/).join

		# Grab the exact unique string of characters
		boundary = '--' + code.gsub(/\nContent-Type: text\/plain/, "")

		# Split the sections by the boundary
		header, content = @text.split(boundary)

		# Call methods with relevant parts
		parse_head(header)
		parse_content(content)
	end
	def parse_head(section)

		# Empty array to put each line into
		lines =[]

		# Clean out all the newlines and whitespace
		header = section.strip.gsub(/\n\s+/, " ")

		# Sort each line that begins with 'want'ed info
		@wants.each { |info| lines << header.scan(/(^#{info.capitalize}: )(.+)(\n)/).join.to_s}

		# Strip out white space, including empty cc/bcc's 
		@labels = lines.join.strip
	end
	def parse_content(section)

		# Remove 'Content' type lines
		@content = section.gsub(/(^Content-)(.+)(:)(.+)(\n)/, "").chomp('--').strip
	end
	def put_content # Format for terminal
		puts "\n"+@labels
		puts "_________________________________\n\n"
		puts @content+"\n"
	end
	def parse_email # Call methods
		break_body
		put_content
	end
end