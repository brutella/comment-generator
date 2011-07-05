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
  
  def self.method_definition method_string
    objc_method_regex = /
                ^\s*                # Start of the line and optional space
                [+-]\s*             # a plus or minus for method specifier
                \([^)]+\)           # the return type in brackets
                ((?:\n|[^@{])*)     
                (?m:[\s;]*)                          
              /x                    # Ignore whitespaces between regex tokens
              
    # TODO: use param regex
    objc_param_regex = /
              :\s*\([^)]\)
              \s*[a-zA-Z].+
              /x
              
    found_method = method_string[objc_method_regex]

    return nil if found_method.nil? or found_method.empty?
  
    result = "/** <#(brief description)#>\n\n"
    result += " <#(comprehensive description)#>\n\n"
    
    found_method = found_method.sub ';', ''
    param_descriptions = found_method.split ':'
    first_param = param_descriptions.shift # Remove first part
    return_value = first_param.split(')').first
    start_index = return_value.index('(') + 1
    length = return_value.length
    return_value = return_value[start_index...length]

    param_descriptions.each do |possible_param|
    	param = possible_param.split(')').last.split(' ').first
    	result += " @param #{param} <#(description of #{param})#>\n"
    end

    if return_value.eql?("void") == false
      result += " @return <#(description of return value)#>\n"
    end

    result += '*/'
  end
  
  def self.class_definition class_string
    objc_class_regex = /
                ^\s*                # Start of the line and optional space
                \@interface\s+      # interface declaration
                [a-zA-Z].+\s*\:        # class name
                /x
    found_class = class_string[objc_class_regex]
    return nil if found_class.nil? or found_class.empty?
    
    class_name = found_class.split(':').first.split(' ').at(1)
    
    result = "/** <#(brief description of #{class_name})#>\n\n"
    result += " <#(comprehensive description)#>\n\n"
    result += "*/"
  end
end