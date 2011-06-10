# Docu Generator
A ruby class to extract documentation from Objective-C code. Currently supported is [appledoc](https://github.com/tomaz/appledoc) documentation for Objective-C class and method definitions.

## Examples

### Method definition
The call 

    AppleDoc.method_definition '- (NSString*)fromString:(NSString*)aString;'

will result in the following appledoc

    /** <#(brief description)#>
      <#(comprehensive description)#>
     
     @param aString <#(description of aString)#>

     @return <#(description of return value)#>
    */