load "appledoc.rb"
require "test/unit"

class AppleDocClassTest < Test::Unit::TestCase
  def test_simple
    assert_equal(
      ObjCClass.new('@interface MyClass : NSObject {').get_comment_string, 
      "/** <#(brief description of MyClass)#>\n\n <#(comprehensive description)#>\n*/")
  end
end