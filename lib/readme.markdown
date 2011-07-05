# Docu Generator
A ruby class to extract documentation from Objective-C code. Currently supported is [appledoc](https://github.com/tomaz/appledoc) documentation for Objective-C class and method definitions.

## Examples

### Method definition
The call 

    method = ObjCMethod.new '- (NSString*)fromString:(NSString*)aString;'
    method.get_comment_string # Create comment

will result in the following appledoc comment

    /** <#(brief description)#>
    
     <#(comprehensive description)#>
     
     @param aString <#(description of aString)#>

     @return <#(description of return value)#>
    */