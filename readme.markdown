# Comment Generator
A ruby class that generates comment templates from Objective-C code. Currently supported is [appledoc](https://github.com/tomaz/appledoc) documentation for Objective-C class and method definitions.

## Use in Xcode

Add a build script phase to a build target and add the following lines. This will add comment templates to all header files from the *./Classes* directory which include Objective-C classes and methods.

    require "rubygems"
	require "commentgen"

	Dir[File.join(ENV['SRCROOT'], "Classes", "**/*.h")].each do |filepath|
	    	next if File.directory?(filepath)
	    	next if File.exists?(filepath) == false

		puts "processing " << filepath
	     file = File.open(filepath, "r")
	     header = file.read
	     header_documented = Cogen.new.parse_string(header)

		file = File.open(filepath, "w")
	    	file.write header_documented
		file.flush
		file.close
	end