require_relative "class_entity"

class ObjCClass < ClassEntity
                   # Ignore whitespaces between regex tokens
    def initialize string
      super
      @regex_representation = /
                  ^\s*                # Start of the line and optional space
                  \@interface\s+      # Declare interface
                  [a-zA-Z].+\s*\:        # class name
                /x                   # Ignore whitespaces between regex tokens                
      raise ArgumentError, "String doesn't contain an Objective-C method definition" if !matches_string(@definition)
      
      initialize_from_definition    
    end
    
    def initialize_from_definition
      @name = @definition.scan(/\s([a-zA-Z]+)\s*\:/).join
    end
    
    def get_comment_string
    comment = 
"/** <#(brief description of #{@name})#>

 <#(comprehensive description)#>
*/"
    end
end