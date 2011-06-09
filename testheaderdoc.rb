load "headerdoc.rb"
require "test/unit"


class TestHeaderDoc < Test::Unit::TestCase
  def test_method_no_returnvalue_one_param
    assert_equal(
      HeaderDoc.from_method_header('- (void)fooMethod:(int)blub;'), 
      "/*!\n @abstract <#(brief description)#>\n @discussion <#(comprehensive description)#>\n\n @param blub <#(description of blub)#>\n*/")
  end
  
  def test_method_no_returnvalue_two_param
    assert_equal(
      HeaderDoc.from_method_header('- (void)fooMethod:(NSInteger)integer float:(CGFfloat)float;'), 
      "/*!\n @abstract <#(brief description)#>\n @discussion <#(comprehensive description)#>\n\n @param integer <#(description of integer)#>\n @param float <#(description of float)#>\n*/")
  end
  
  def test_method_no_returnvalue_no_param
    assert_equal(
      HeaderDoc.from_method_header('- (void)fooMethod;'), 
      "/*!\n @abstract <#(brief description)#>\n @discussion <#(comprehensive description)#>\n\n*/")
  end
  
  def test_method_return_object_no_param
    assert_equal(
      HeaderDoc.from_method_header('- (NSString*)toString;'), 
      "/*!\n @abstract <#(brief description)#>\n @discussion <#(comprehensive description)#>\n\n @result \n*/")
  end
  
  def test_method_no_spacing
    assert_equal(
      HeaderDoc.from_method_header('-(NSString*)toString;'), 
      "/*!\n @abstract <#(brief description)#>\n @discussion <#(comprehensive description)#>\n\n @result \n*/")
  end
  
  def test_method_full_of_spacing
    assert_equal(
      HeaderDoc.from_method_header('- ( NSString *) toString ;'), 
      "/*!\n @abstract <#(brief description)#>\n @discussion <#(comprehensive description)#>\n\n @result \n*/")
  end
  
  def test_method_full_of_return_spacing
    assert_equal(
      HeaderDoc.from_method_header('- ( NSString * )toString;'), 
      "/*!\n @abstract <#(brief description)#>\n @discussion <#(comprehensive description)#>\n\n @result \n*/")
  end
  
  def test_static_method
    assert_equal(
      HeaderDoc.from_method_header('+ (void)fooMethod;'), 
      "/*!\n @abstract <#(brief description)#>\n @discussion <#(comprehensive description)#>\n\n*/")
  end
  
end