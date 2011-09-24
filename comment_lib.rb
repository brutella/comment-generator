require 'rubygems'
require 'cogen'

@rdoc = RDoc.new
Dir[File.join("lib", "**/*.rb")].each do |filepath|
        next if File.directory?(filepath)
        next if File.exists?(filepath) == false

    puts "processing " << filepath
    file = File.open(filepath, "r")
    ruby_code = file.read
    ruby = RubyCode.new(ruby_code, @rdoc)
    ruby.parse_code
    code_documented = ruby.generated_string
    next if ruby_code.hash == code_documented.hash
    
    file = File.open(filepath, "w")
    file.write code_documented
    file.flush
    file.close
end