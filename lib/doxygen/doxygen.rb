require_relative '../base/comment_syntax'
require_relative '../base/class_entity'
require_relative '../base/method_entity'

# (DoxygenCommentSyntax brief description)
# 
# (Comprehensive description)
# 
class Doxygen < CommentSyntax
  
  # (commentStart? brief description)
  # 
  # (Comprehensive description)
  # 
  # [string] 
  # 
  def commentStart? string
    doxygen_start_regex = /\/\*\*/
    return !string[doxygen_start_regex].nil?                
  end
  
  # (string_for_class_entity brief description)
  # 
  # (Comprehensive description)
  # 
  # [e] 
  # 
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