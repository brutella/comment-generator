require_relative '../base/comment_syntax'
require_relative '../base/class_entity'
require_relative '../base/method_entity'

class RDoc < CommentSyntax
  def string_for_class_entity e
    comment = 
"# #{e.name} brief description
# Comprehensive description"
  end
  
  def string_for_method_entity e
  end

end