require_relative 'commentable_entity'

class MethodEntity < CommentableEntity
  attr_accessor :name
  attr_accessor :param_names
  attr_accessor :param_types
  attr_accessor :return_value
end