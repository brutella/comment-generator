require_relative "../lib/cogen"
require "test/unit"

class ObjCClassTest < Test::Unit::TestCase
  def test_simple
    assert_equal(
      ObjCClass.new('@interface MyClass : NSObject {').doxygen_comment_string, 
      "/** <#(brief description of MyClass)#>\n\n <#(comprehensive description)#>\n*/")
  end
end