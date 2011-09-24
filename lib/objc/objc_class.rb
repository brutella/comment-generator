require_relative "../base/class_entity"
require_relative "../doxygen/doxygen"

# (ObjCClassClassEntity brief description)
# 
# (Comprehensive description)
# 
class ObjCClass < ClassEntity    
    # (initialize brief description)
    # 
    # (Comprehensive description)
    # 
    # [string] 
    # [syntax] 
    # 
    def initialize string, syntax
      super string, syntax
      @regex_representation = /
                  ^\s*                # Start of the line and optional space
                  \@interface\s+      # Declare interface
                  [a-zA-Z].+\s*\:        # class name
                /x                   # Ignore whitespaces between regex tokens                
      raise ArgumentError, "String doesn't contain an Objective-C method definition" if !matches_with_string(@definition)
      
      initialize_from_definition    
    end
    
    def initialize_from_definition
      @name = @definition.scan(/\s([a-zA-Z]+)\s*\:/).join
    end
end