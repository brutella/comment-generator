require_relative "commentable_entity"

# Represents a class entity
# 
# A class entity in a programming language.
# 
class ClassEntity < CommentableEntity
  attr_accessor :name
  
  # Returns the comment string of this entity based
  # on the comment syntax
  # 
  def comment_string
    @comment_syntax.string_for_class_entity self
  end
end