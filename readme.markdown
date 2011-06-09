# HeaderDoc Generator
A ruby class to extract headerdoc documentation from Objective-C code. Currently supported are method definitions from the header.

## Example
The call 

    HeaderDoc.from_method_header '- (NSString*)fromString:(NSString*)aString;'

will result in the following headerdoc

    /*!
     @abstract <#(brief description)#>
     @discussion <#(comprehensive description)#>
     
     @param aString <#(description of aString)#>

     @result
    */