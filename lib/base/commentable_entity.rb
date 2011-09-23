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
  
  def documented
    @isDocumented
  end
  
  def matches_with_string string
    result = string[@regex_representation]
    return false if result.nil? or result.empty?    
    true
  end
  
  def comment_string
    raise NotImplementedError
  end
end