require_relative "objc_class"
require_relative "objc_method"

class CommentGen
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
      already_documented = already_documented || ! line[appledoc_start_regex].nil?
      @entityClasses.each do |entity_class|
        begin
          entity = Object.const_get(entity_class).new line
          if already_documented
            already_documented = false
          else
            new_string += entity.get_comment_string + "\n"  
          end
        rescue
        end
      end
            
      new_string += line
    end
    
    return new_string
  end
end