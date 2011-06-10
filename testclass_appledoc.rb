load "appledoc.rb"
require "test/unit"

class AppleDocGeneratorClassTest < Test::Unit::TestCase
  def test_simple
    assert_equal(
      AppleDocGenerator.class_definition('@interface MyClass : NSObject {'), 
      "/** <#(brief description of MyClass)#>\n\n <#(comprehensive description)#>\n\n*/")
  end
end