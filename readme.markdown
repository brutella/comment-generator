# Docu Generator
A ruby class to extract documentation from Objective-C code. Currently supported is [appledoc](https://github.com/tomaz/appledoc) documentation for Objective-C class and method definitions.

## Use in Xcode

Add a build script phase to a build target and add the following lines. This will add comments to all header files which include Objective-C classes and methods.

    require "rubygems"
	require "commentgen"

	Dir.foreach(ENV['SRCROOT']) do |filepath|
	    next if File.directory?(filepath)
	    next if filepath.include?(".h") == false
	    next if File.exists?(filepath) == false

		puts "processing " << filepath
	    file = File.open(filepath, "r")
	    header = file.read
	    header_documented = CommentGen.new.parse_string(header)

		file = File.open(filepath, "w")
	    	file.write header_documented
		file.flush
		file.close
	end