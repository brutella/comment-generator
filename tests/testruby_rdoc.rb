require_relative "../lib/ruby/ruby_class"
require "test/unit"

class RubyClassTest < Test::Unit::TestCase
  def setup
    @rdoc_syntax = RDoc.new
  end
  
  def test_simple
    assert_equal(
      RubyClass.new('class MyRubyClass ', @rdoc_syntax).comment_string, 
"# MyRubyClass brief description
# Comprehensive description")
  end
  
  def test_simple_with_superclass
    assert_equal(
      RubyClass.new('class MyRubyClass < SuperClass', @rdoc_syntax).comment_string, 
"# MyRubyClass brief description
# Comprehensive description")
  end
  
  def test_not_a_ruby_class_string
    begin
      RubyClass.new('class myRubyClass < SuperClass', @rdoc_syntax)
    rescue ArgumentError
      return
    end
    fail "ArgumentError expected, because string is not a valid ruby class definition"
  end
  
  def test_ruby_class_name_extraction
    ruby_class = RubyClass.new('class MyClass < B', @rdoc_syntax)
    assert_equal "MyClass", ruby_class.name
  end
end