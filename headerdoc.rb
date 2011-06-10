class HeaderDoc  
  def self.method_definition header_string
    objc_method_regex = /
                ^\s*                # Start of the line and optional space
                [+-]\s*             # a plus or minus for method specifier
                \([^)]+\)           # the return type in brackets
                ((?:\n|[^@{])*)     
                (?m:[\s;]*)
    			;                           
              /x
              
    found_method = header_string[objc_method_regex]

    exit if found_method.nil? or found_method.empty?
  
    result = "/*!\n"
    result += " @abstract <#(brief description)#>\n"
    result += " @discussion <#(comprehensive description)#>\n\n"
    
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
      result += " @result <#(description of return value)#>\n"
    end

    result += '*/'
  end
end