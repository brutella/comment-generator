# (CommentableEntity brief description)
# 
# (Comprehensive description)
# 
class CommentableEntity
  attr_accessor :regex_representation
  attr_accessor :definition
  attr_accessor :comment_syntax
  # TODO: needed?
  attr_accessor :isDocumented
  
  def initialize string, comment_syntax
    @comment_syntax = comment_syntax
    @definition = string
    @isDocumented = false
  end
  
  # (documented brief description)
  # 
  # (Comprehensive description)
  # 
  def documented
    @isDocumented
  end
  
  # (matches_with_string brief description)
  # 
  # (Comprehensive description)
  # 
  # [string] 
  # 
  def matches_with_string string
    result = string[@regex_representation]
    return false if result.nil? or result.empty?    
    true
  end
  
  # (comment_string brief description)
  # 
  # (Comprehensive description)
  # 
  def comment_string
    raise NotImplementedError
  end
end