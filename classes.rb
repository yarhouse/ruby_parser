class Parse

	def parse_it (text)
		
		# I opted to go with counting backwards from the plain text content type
		# as I found some emails contain more than one boundary code with multiparts
		code = text.scan(/^--(.+)(\n)(Content-Type: text\/plain)/).join

		# Grab the exact unique string of characters to split the entire body by
		boundary = '--' + code.gsub(/\nContent-Type: text\/plain/, "")

		# Split the sections by the boundary and get relevant/readable
		sections = text.split(boundary)

		# Clean out all the newlines and whitespace so that we'll have all 'Something: Other stuff'
		$header = sections[0].strip.gsub(/\n\s+/, " ")

		# Clean off the 'Content type:' line and the dashes for a nice output
		$content = sections[1].strip.gsub(/(^C)(.+)/, "").strip.chomp('--')

		# Method for the header
		def parse_head (object, section)
			
			# Empty array to put each line into
			lines =[]

			# Sort through the header section to find each line that begins with a "want"ed info
			object.each { |info| lines << section.scan(/(^#{info.capitalize}: )(.+)(\n)/).join.to_s}

			# Strip out the white spaces, possibly including empty cc's and bcc's that come up blank
			puts lines.join.strip
		end

		parse_head($wants, $header)
		puts "________________________________________"
		puts
		puts $content
	end
end