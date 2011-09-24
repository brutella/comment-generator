require 'rubygems'
require 'cogen'

@rdoc = RDoc.new
Dir[File.join("lib", "**/*.rb")].each do |filepath|
        next if File.directory?(filepath)
        next if File.exists?(filepath) == false

    file = File.open(filepath, "r")
    ruby_code = file.read
    puts ruby_code
    code_documented = RubyCode.new(ruby_code, @rdoc).parse_code
    next if ruby_code.hash == code_documented.hash

    puts code_documented
    # file = File.open(filepath, "w")
    # file.write code_documented
    # file.flush
    # file.close
end