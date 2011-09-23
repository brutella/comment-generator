=begin
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
=end

require_relative '../base/comment_syntax'
require_relative '../base/class_entity'
require_relative '../base/method_entity'

class Doxygen < CommentSyntax
  def string_for_class_entity e
    comment = 
"/** <#(brief description of #{e.name})#>

 <#(comprehensive description)#>
*/"
  end
  
  def string_for_method_entity e
    comment = 
"/** <#(brief description)#>

 <#(comprehensive description)#>
";

    if e.param_types.length > 0
        comment += "\n"
        e.param_names.each { |param| comment += " @param #{param} <#(description of #{param})#>\n" }
    end

    if e.return_value.eql?("void") == false
      comment += "\n @return <#(description of return value)#>\n"
    end 
    
    comment += "*/"
  end

end