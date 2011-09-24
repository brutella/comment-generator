require 'rubygems'
require 'cogen'

require "test/unit"

class CodeTest < Test::Unit::TestCase
  def setup
    @rdoc_syntax = RDoc.new
    @doxygen_syntax = Doxygen.new
  end
  
  def test_ruby_rdoc
    plain_code = File.open("ruby_code.rb", "r").read
    commented_code = File.open("ruby_code_commented.rb", "r").read
    
    ruby_code = RubyCode.new plain_code, @rdoc_syntax
    ruby_code.parse_code
    
    assert_equal(commented_code, ruby_code.generated_string)
  end
  
  def test_objectivec_doxygen
    plain_code = File.open("Example.h", "r").read
    commented_code = File.open("Example_documented.h", "r").read
    
    code = ObjCCode.new plain_code, @doxygen_syntax
    code.parse_code
    
    assert_equal(commented_code, code.generated_string)
  end
  
end