class AppleDocGenerator
  attr_accessor :methods
  attr_accessor :classes
  
  def self.parse_header header_string
    appledoc_start_regex = /
                \/\*\*
                /x
                
    new_header_string = ""
    
    already_documented = false
    header_string.each_line do |line|
      already_documented = already_documented || ! line[appledoc_start_regex].nil?
      docu = AppleDocGenerator.method_definition line
      if docu
        if already_documented
          already_documented = false
        else
          new_header_string += docu + "\n"  
        end
      end
      
      docu = AppleDocGenerator.class_definition line
      if docu
        if already_documented
          already_documented = false
        else
          new_header_string += docu + "\n"  
        end
      end
      
      new_header_string += line
    end
    
    return new_header_string
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

class CodeMethod
  attr_accessor :definition
  attr_accessor :name
  attr_accessor :param_names
  attr_accessor :param_types
  attr_accessor :return_value
end

# - (NSString*) fromString:(NSString*)aString andFloat:(CGFloat)float
class ObjCMethod < CodeMethod            
  def initialize method_string
    @definition = method_string
    @param_names = Array.new
    
    @objc_method_regex = /
                ^\s*                # Start of the line and optional space
                [+-]\s*             # a plus or minus for method specifier
                \([^)]+\)           # the return type in brackets
                ((?:\n|[^@{])*)     
                (?m:[\s;]*)                          
              /x                    # Ignore whitespaces between regex tokens                
    initialize_from_definition
  end
  
  def initialize_from_definition
    found_method = @definition[@objc_method_regex]

    exit if found_method.nil? or found_method.empty?
    
    @name = @definition.scan(/([^\s^\(^\)]+\:)/).join
    param_names = Array.new 
    @definition.scan(/([^\)^\s^\(^\-^\+]+)\s/){ |temp| param_names << temp.shift }
    @param_names = param_names
    
    param_types = Array.new    
    @definition.scan(/\(([^\)]+)\)/).map { |temp| param_types << temp.shift }
    @return_value = param_types.shift.to_s
    @param_type = param_types
    
  end
  
  def get_comment_string
    comment = 
"/** <#(brief description)#>
 <#(comprehensive description)#>
";
    params_comment = @param_names.count > 0 ? "\n" : ""
    @param_names.each do |param|
      params_comment += " @param #{param} <#(description of #{param})#>\n"
    end
    
    if param_names.count > 0
      comment += params_comment
    end
    
    if @return_value.eql?("void") == false
      comment += "\n @return <#(description of return value)#>\n"
    end
  
    comment += "*/"
  end
end

method = ObjCMethod.new "- (NSObject*)fromString:(NSString*)blub param2:(NSString*)anotherOne andAnotherOne:(int)blub"
puts "definition: " + method.definition
puts "return value: " + method.return_value
puts "params: " + method.param_names.to_s
puts method.get_comment_string