load "appledoc.rb"
require "test/unit"


class AppleDocMethodTest < Test::Unit::TestCase
  def test_method_no_returnvalue_one_param
    assert_equal(
      AppleDoc.method_definition('- (void)fooMethod:(int)blub;'), 
      "/** <#(brief description)#>\n <#(comprehensive description)#>\n\n @param blub <#(description of blub)#>\n*/")
  end
  
  def test_method_no_returnvalue_two_param
    assert_equal(
      AppleDoc.method_definition('- (void)fooMethod:(NSInteger)integer float:(CGFfloat)float;'), 
      "/** <#(brief description)#>\n <#(comprehensive description)#>\n\n @param integer <#(description of integer)#>\n @param float <#(description of float)#>\n*/")
  end
  
  def test_method_no_returnvalue_no_param
    assert_equal(
      AppleDoc.method_definition('- (void)fooMethod;'), 
      "/** <#(brief description)#>\n <#(comprehensive description)#>\n\n*/")
  end
  
  def test_method_return_object_no_param
    assert_equal(
      AppleDoc.method_definition('- (NSString*)toString;'), 
      "/** <#(brief description)#>\n <#(comprehensive description)#>\n\n @return <#(description of return value)#>\n*/")
  end
  
  def test_method_no_spacing
    assert_equal(
      AppleDoc.method_definition('-(NSString*)toString;'), 
      "/** <#(brief description)#>\n <#(comprehensive description)#>\n\n @return <#(description of return value)#>\n*/")
  end
  
  def test_method_full_of_spacing
    assert_equal(
      AppleDoc.method_definition('- ( NSString *) toString ;'), 
      "/** <#(brief description)#>\n <#(comprehensive description)#>\n\n @return <#(description of return value)#>\n*/")
  end
  
  def test_method_full_of_return_spacing
    assert_equal(
      AppleDoc.method_definition('- ( NSString * )toString;'), 
      "/** <#(brief description)#>\n <#(comprehensive description)#>\n\n @return <#(description of return value)#>\n*/")
  end
  
  def test_static_method
    assert_equal(
      AppleDoc.method_definition('+ (void)fooMethod;'), 
      "/** <#(brief description)#>\n <#(comprehensive description)#>\n\n*/")
  end
  
end