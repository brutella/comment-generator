load "appledoc.rb"
require "test/unit"

class AppleDocGeneratorClassTest < Test::Unit::TestCase
  def test_simple
    header = 
"// Somme comments here

@interface MyClass:NSObject{}

- (void)aMethod;
@end"
    
    assert_equal(
       AppleDocGenerator.parse_header(header), 
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
  
  def test_with_header_file
    
    file = File.open("Example.h", "r")
    header = file.read
    header_documented = AppleDocGenerator.parse_header(header)
    File.open("Example_documented.h", 'w') {|f| f.write(header_documented) }
  end
  
end