require_relative "../base/class_entity"
require_relative "../rdoc/rdoc"

# (RubyClassClassEntity brief description)
# 
# (Comprehensive description)
# 
class RubyClass < ClassEntity
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
                  class\s+            # class
                  [A-Z][a-zA-Z]*      # class name
                  [\s|\n]
                /x                    # Ignore whitespaces between regex tokens                
      raise ArgumentError, "String doesn't contain an Ruby class definition" if !matches_with_string(@definition)
      
      initialize_from_definition
    end
    
    def initialize_from_definition
      @name = @definition.scan(/\s([A-Z][a-zA-Z]*)[\s|\n]/).join
    end
end