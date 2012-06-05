class Parse 
	def break_body (text)
		code = text.scan(/^--(.+)(\n)(Content-Type: text\/plain)/).join
		boundary = '--' + code.gsub(/\nContent-Type: text\/plain/, "")
		sections = text.split(boundary)
		@header = sections[0].strip.gsub(/\n\s+/, " ")
		@content = sections[1].strip.gsub(/(^C)(.+)/, "").strip.chomp('--')
	end
	def parse_head (object)
		lines =[]
		object.each { |info| lines << @header.scan(/(^#{info.capitalize}: )(.+)(\n)/).join.to_s}
		puts lines.join.strip
	end
	def put_content
		puts "______________________________"
		puts
		puts @content
	end
end