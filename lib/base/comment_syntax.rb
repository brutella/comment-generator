class CommentSyntax
  def string_for_class_entity class_entity
    raise NotImplementedError
  end
  
  def string_for_method_entity class_entity
    raise NotImplementedError
  end
end