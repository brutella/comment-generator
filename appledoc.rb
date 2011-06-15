class AppleDocGenerator
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

class CommentableEntity
  attr_accessor :regex_representation
  attr_accessor :definition
  attr_accessor :isDocumented
  
  def initialize string
    @definition = string
    @isDocumented = false
  end
  
  def documented
    @isDocumented
  end
  
  def matches_string string
    result = string[@regex_representation]
    return false if result.nil? or result.empty?    
    true
  end
  
  def get_comment_string
    raise NotImplementedError
  end
end

class MethodEntity < CommentableEntity
  attr_accessor :name
  attr_accessor :param_names
  attr_accessor :param_types
  attr_accessor :return_value
end

class ClassEntity < CommentableEntity
  attr_accessor :name
end

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

class ObjCMethod < MethodEntity            
  def initialize string
    super
    @regex_representation = /
                 ^\s*                # Start of the line and optional space
                 [+-]\s*             # a plus or minus for method specifier
                 \([^)]+\)           # the return type in brackets
                 ((?:\n|[^@{])*)     
                 (?m:[\s;]*)                          
               /x                    # Ignore whitespaces between regex tokens                
               
    raise ArgumentError, "String doesn't contain an Objective-C method definition" unless matches_string @definition
    
    initialize_from_definition
  end
  def initialize_from_definition
    found_method = @definition[@regex_representation]

    exit if found_method.nil? or found_method.empty?
    
    @name = @definition.scan(/([^\s^\(^\)]+\:)/).join
    param_names = Array.new 
    @definition.scan(/\)([^\)^\s^\(^\-^\+^\;^\{^\:]+)/){ |temp| param_names << temp.shift }
    param_names.shift # Remove name of first parameter
    @param_names = param_names
    
    param_types = Array.new    
    @definition.scan(/\(([^\)]+)\)/).map { |temp| param_types << temp.shift }
    @return_value = param_types.shift.to_s
    @param_types = param_types
  end
 
  def get_comment_string
    comment = 
"/** <#(brief description)#>

 <#(comprehensive description)#>
";

    if @param_types.length > 0
        comment += "\n"
        @param_names.each { |param| comment += " @param #{param} <#(description of #{param})#>\n" }
    end
    
    if @return_value.eql?("void") == false
      comment += "\n @return <#(description of return value)#>\n"
    end
  
    comment += "*/"
  end

end