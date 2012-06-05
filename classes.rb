class Parse 
	def initialize(text, wants)
		@text = text
		@wants = wants
	end
	def break_body

		# I opted to go with counting backwards from the plain text content type
		# as I found some emails contain more than one boundary code with multiparts
		code = @text.scan(/^--(.+)(\n)(Content-Type: text\/plain)/).join

		# Grab the exact unique string of characters to split the entire body by
		boundary = '--' + code.gsub(/\nContent-Type: text\/plain/, "")

		# Split the sections by the boundary and get relevant/readable
		@sections = @text.split(boundary)
	end
	def parse_head

		# Empty array to put each line into
		lines =[]

		# Clean out all the newlines and whitespace so that we'll have all 'Something: Other stuff'
		header = @sections[0].strip.gsub(/\n\s+/, " ")

		# Sort through the header section to find each line that begins with a "want"ed info
		@wants.each { |info| lines << header.scan(/(^#{info.capitalize}: )(.+)(\n)/).join.to_s}

		# Strip out the white spaces, possibly including empty cc's and bcc's that come up blank
		@labels = lines.join.strip
	end
	def parse_content

		# Clean off the 'Content type:' line and the dashes for a nice output
		@content = @sections[1].strip.gsub(/(^C)(.+)/, "").strip.chomp('--')
	end
	def put_content

		# Format for terminal
		puts "\n"+@labels
		puts "_________________________________\n\n"
		puts @content+"\n"
	end
	def parse_email
		break_body
		parse_head
		parse_content
		put_content
	end
end