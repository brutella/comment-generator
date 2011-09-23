require_relative "../lib/cogen"
require "test/unit"

class ObjCClassTest < Test::Unit::TestCase
  def test_simple
    assert_equal(
      ObjCClass.new('@interface MyClass : NSObject {').doxygen_comment_string, 
      "/** <#(brief description of MyClass)#>\n\n <#(comprehensive description)#>\n*/")
  end
  def test_not_a_ruby_class_string
    begin
      ObjCClass.new('@interface MyClass')
    rescue ArgumentError
      return
    end
    fail "ArgumentError expected, because string is not a valid Objective-C class definition"
  end
  
  def test_ruby_class_name_extraction
    objc_class = ObjCClass.new'@interface MyClass : NSObject'
    assert_equal "MyClass", objc_class.name
  end
  
end