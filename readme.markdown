# Docu Generator
A ruby class to extract documentation from Objective-C code. Currently supported is headerdoc documentation from method definitions.

## Example
The call 

    HeaderDoc.from_method_definition '- (NSString*)fromString:(NSString*)aString;'

will result in the following headerdoc

    /*!
     @abstract <#(brief description)#>
     @discussion <#(comprehensive description)#>
     
     @param aString <#(description of aString)#>

     @result <#(description of return value)#>
    */