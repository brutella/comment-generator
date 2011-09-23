class CommentableEntity
  attr_accessor :regex_representation
  attr_accessor :definition
  attr_accessor :possible_comments
  # TODO: needed?
  attr_accessor :isDocumented
  
  def initialize string
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
  
  def get_comment_string
    raise NotImplementedError
  end
end