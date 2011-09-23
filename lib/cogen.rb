require_relative "objc_class"
require_relative "objc_method"

class Cogen
  attr_accessor :entityClasses
  
  def initialize 
    @entityClasses = Array.new
    @entityClasses << :ObjCClass
    @entityClasses << :ObjCMethod
  end
  
  def parse_string string
    appledoc_start_regex = /
                \/\*\*
                /x
                
    new_string = ""
    
    already_documented = false
    string.each_line do |line|
      @entityClasses.each do |entity_class|
        already_documented  = already_documented || Object.const_get(entity_class).maybeCommentString?(line)
        
        begin
          entity = Object.const_get(entity_class).new line
          if already_documented
            already_documented = false
          else
            new_string += entity.doxygen_comment_string + "\n"  
          end
        rescue
        end
      end
            
      new_string += line
    end
    
    return new_string
  end
end