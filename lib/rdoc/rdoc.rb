require_relative '../base/comment_syntax'
require_relative '../base/class_entity'
require_relative '../base/method_entity'

# (RDocCommentSyntax brief description)
# 
# (Comprehensive description)
# 
class RDoc < CommentSyntax
  # (commentStart? brief description)
  # 
  # (Comprehensive description)
  # 
  # [string] 
  # 
  def commentStart? string
    rdoc_start_regex = /\#/
    return !string[rdoc_start_regex].nil?                
  end
  
  def string_for_class_entity e
    comment = 
"# (#{e.name} brief description)
# 
# (Comprehensive description)
# "
  end
  
  def string_for_method_entity e
comment = 
"# (#{e.name} brief description)
# 
# (Comprehensive description)
";

    if e.param_names.length > 0
        comment += "# \n"
        e.param_names.each { |param| comment += "# [#{param}] \n" }
    end
    
    comment += "# "
  end

end