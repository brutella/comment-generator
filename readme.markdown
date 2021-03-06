# Comment Generator
A ruby classes that generates comment templates from source code. Currently supported are Objective-C and Ruby code, which can be commented with [doxygen](http://www.doxygen.org/) and [RDoc](http://rdoc.sourceforge.net/) documentation syntax respectively.

## Use in Xcode

Add a build script phase to a build target and add the following lines. This will add comment templates to all header files from the *./Classes* directory which include Objective-C classes and methods.

    require "rubygems"
	require "cogen"
	
	@doxygen = Doxygen.new
	Dir[File.join(ENV['SRCROOT'], "Classes", "**/*.h")].each do |filepath|
	    	next if File.directory?(filepath)
	    	next if File.exists?(filepath) == false

		puts "processing " << filepath
	    code_string = File.open(filepath, "r").read
		
		objc = ObjCCode.new(code_string, @doxygen)
    	objc.parse_code
    	code_documented = objc.generated_string
    	next if code_string.hash == code_documented.hash
    
    	file = File.open(filepath, "w")
    	file.write code_documented
    	file.flush
    	file.close
	end