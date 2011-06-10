class AppleDoc  
  def self.method_definition header_string
    objc_method_regex = /
                ^\s*                # Start of the line and optional space
                [+-]\s*             # a plus or minus for method specifier
                \([^)]+\)           # the return type in brackets
                ((?:\n|[^@{])*)     
                (?m:[\s;]*)
    			;                           
              /x                    # Ignore whitespaces between regex tokens
              
    found_method = header_string[objc_method_regex]

    return nil if found_method.nil? or found_method.empty?
  
    result = "/** <#(brief description)#>\n"
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
                [a-zA-Z]+\s*        # class name
                /x
    found_class = class_string[objc_class_regex]
    return nil if found_class.nil? or found_class.empty?
    
    class_name = found_class.split(' ').at(1)
    
    result = "/** <#(brief description of #{class_name})#>\n"
    result += " <#(comprehensive description)#>\n\n"
    result += "*/"
  end
end