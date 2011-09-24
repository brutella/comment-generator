require_relative 'commentable_entity'

# (MethodEntityCommentableEntity brief description)
# 
# (Comprehensive description)
# 
class MethodEntity < CommentableEntity  
  attr_accessor :name
  attr_accessor :param_names
  attr_accessor :param_types
  attr_accessor :return_value
  
  # (comment_string brief description)
  # 
  # (Comprehensive description)
  # 
  def comment_string
    @comment_syntax.string_for_method_entity self
  end
end