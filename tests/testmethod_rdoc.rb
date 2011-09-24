require_relative "../lib/ruby/ruby_method"
require_relative "../lib/rdoc/rdoc"
require "test/unit"

class RubyMethodRDoc < Test::Unit::TestCase
  def setup
    @rdoc_syntax = RDoc.new
  end
  
  def test_name
    ruby_method = RubyMethod.new('def isValid?', @rdoc_syntax)
    assert_equal "isValid?", ruby_method.name
  end
  
  def test_arguments
    assert_equal(
"# (my_new_method brief description)
# 
# (Comprehensive description)
# 
# [a_string] 
# [an_integer] 
# ", RubyMethod.new('def my_new_method a_string, an_integer', @rdoc_syntax).comment_string)
  end
  
  def test_static_method
    assert_equal(
"# (self.static_method brief description)
# 
# (Comprehensive description)
# ", RubyMethod.new('def self.static_method', @rdoc_syntax).comment_string)
  end
  
  def test_double_underscore
    assert_equal(
"# (should_do_parsing brief description)
# 
# (Comprehensive description)
# ", RubyMethod.new('def should_do_parsing', @rdoc_syntax).comment_string)
  end
  
  def test_no_arguments
      assert_equal(
"# (print brief description)
# 
# (Comprehensive description)
# ", RubyMethod.new('def print', @rdoc_syntax).comment_string)
  end
    
  def test_arguments_with_defaults
      assert_equal(
"# (parse brief description)
# 
# (Comprehensive description)
# 
# [a_string=nil] 
# ", RubyMethod.new('def parse a_string=nil', @rdoc_syntax).comment_string)
  end
    
  def test_method_with_question_mark
      assert_equal(
"# (isValid? brief description)
# 
# (Comprehensive description)
# ", RubyMethod.new('def isValid?', @rdoc_syntax).comment_string)
  end
  
end