load "appledoc.rb"
require "test/unit"


class AppleDocGeneratorMethodTest < Test::Unit::TestCase
  def test_method_no_returnvalue_one_param
    assert_equal(
      AppleDocGenerator.method_definition('- (void)fooMethod:(int)blub;'), 
      "/** <#(brief description)#>\n\n <#(comprehensive description)#>\n\n @param blub <#(description of blub)#>\n*/")
  end
  
  def test_method_no_returnvalue_two_param
    assert_equal(
      AppleDocGenerator.method_definition('- (void)fooMethod:(NSInteger)integer float:(CGFfloat)float;'), 
      "/** <#(brief description)#>\n\n <#(comprehensive description)#>\n\n @param integer <#(description of integer)#>\n @param float <#(description of float)#>\n*/")
  end
  
  def test_method_no_returnvalue_two_param_no_semicolon
    assert_equal(
      AppleDocGenerator.method_definition('- (void)fooMethod:(NSInteger)integer float:(CGFfloat)float'), 
      "/** <#(brief description)#>\n\n <#(comprehensive description)#>\n\n @param integer <#(description of integer)#>\n @param float <#(description of float)#>\n*/")
  end
  
  def test_method_no_returnvalue_no_param
    assert_equal(
      AppleDocGenerator.method_definition('- (void)fooMethod;'), 
      "/** <#(brief description)#>\n\n <#(comprehensive description)#>\n\n*/")
  end
  
  def test_method_return_object_no_param
    assert_equal(
      AppleDocGenerator.method_definition('- (NSString*)toString;'), 
      "/** <#(brief description)#>\n\n <#(comprehensive description)#>\n\n @return <#(description of return value)#>\n*/")
  end
  
  def test_method_return_object_one_param
    assert_equal(
      AppleDocGenerator.method_definition('- (NSString*)fromString:(NSString*)aString;'), 
      "/** <#(brief description)#>\n\n <#(comprehensive description)#>\n\n @param aString <#(description of aString)#>\n @return <#(description of return value)#>\n*/")
  end
  
  def test_method_no_spacing
    assert_equal(
      AppleDocGenerator.method_definition('-(NSString*)toString;'), 
      "/** <#(brief description)#>\n\n <#(comprehensive description)#>\n\n @return <#(description of return value)#>\n*/")
  end
  
  def test_method_full_of_spacing
    assert_equal(
      AppleDocGenerator.method_definition('- ( NSString *) toString ;'), 
      "/** <#(brief description)#>\n\n <#(comprehensive description)#>\n\n @return <#(description of return value)#>\n*/")
  end
  
  def test_method_full_of_return_spacing
    assert_equal(
      AppleDocGenerator.method_definition('- ( NSString * )toString;'), 
      "/** <#(brief description)#>\n\n <#(comprehensive description)#>\n\n @return <#(description of return value)#>\n*/")
  end
  
  def test_static_method
    assert_equal(
      AppleDocGenerator.method_definition('+ (void)fooMethod;'), 
      "/** <#(brief description)#>\n\n <#(comprehensive description)#>\n\n*/")
  end
  
  
end