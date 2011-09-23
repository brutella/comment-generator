# Doxygen class comments
module DoxygenClassComment
  def doxygen_comment_string
    comment = 
"/** <#(brief description of #{@name})#>

 <#(comprehensive description)#>
*/"    
  end
end

# Doxygen method comments
module DoxygenMethodComment
  def doxygen_comment_string
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