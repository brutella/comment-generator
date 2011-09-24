# An entity in a programming language which can be commented
# 
# Eg. classes or method of a specific programming language are
# possible commentable entites.
# 
class CommentableEntity
  attr_accessor :regex_representation
  attr_accessor :definition
  attr_accessor :comment_syntax
  
  def initialize string, comment_syntax
    @comment_syntax = comment_syntax
    @definition = string
    @isDocumented = false
  end
  
  # Checks if a string matches the regex representation of the entity
  # 
  # [string] The string which may represents this entity
  # 
  def matches_with_string string
    result = string[@regex_representation]
    return false if result.nil? or result.empty?    
    true
  end
  
  # Returns the comment for this entity
  # 
  # The generated comment is based on the comment syntax and the type of entity.
  # Subclasses should implemented this method
  # 
  def comment_string
    raise NotImplementedError
  end
end