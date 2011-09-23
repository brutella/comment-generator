require_relative "../lib/cogen"
require "test/unit"

class CogenClassTest < Test::Unit::TestCase
  def test_simple
    header = 
"// Somme comments here

@interface MyClass:NSObject{}

- (void)aMethod;
@end"
    
    assert_equal(
       Cogen.new.parse_string(header), 
"// Somme comments here

/** <#(brief description of MyClass)#>

 <#(comprehensive description)#>
*/
@interface MyClass:NSObject{}

/** <#(brief description)#>

 <#(comprehensive description)#>
*/
- (void)aMethod;
@end")

  end
  
  def test_already_documented
    header = 
"// Somme comments here

@interface MyClass:NSObject{}

/** A documentation
*/
- (void)aMethod;
@end"
    
    assert_equal(
       Cogen.new.parse_string(header), 
"// Somme comments here

/** <#(brief description of MyClass)#>

 <#(comprehensive description)#>
*/
@interface MyClass:NSObject{}

/** A documentation
*/
- (void)aMethod;
@end")

  end
  
  def test_with_header_file
    
    file = File.open("Example.h", "r")
    header = file.read
    header_documented = Cogen.new.parse_string(header)

    if File.exists?("Example_documented.h")
      file = File.open("Example_documented.h", "r")
      header_doc = file.read
      assert_equal(header_documented, header_doc)
    else
      File.open("Example_documented.h", 'w') {|f| f.write(header_documented) }
    end
  end
  
end