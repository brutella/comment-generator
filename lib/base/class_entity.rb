require_relative "commentable_entity"

class ClassEntity < CommentableEntity
  attr_accessor :name
  
  def comment_string
    @comment_syntax.string_for_class_entity self
  end
end