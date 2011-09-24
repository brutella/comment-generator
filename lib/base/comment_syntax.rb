# Abstract class of a comment syntax
# 
class CommentSyntax
  
  # (commentStart? brief description)
  # 
  # (Comprehensive description)
  # 
  # [string] 
  # 
  def commentStart? string
    raise NotImplementedError
  end
  
  # (string_for_class_entity brief description)
  # 
  # (Comprehensive description)
  # 
  # [class_entity] 
  # 
  def string_for_class_entity class_entity
    raise NotImplementedError
  end
  
  # (string_for_method_entity brief description)
  # 
  # (Comprehensive description)
  # 
  # [class_entity] 
  # 
  def string_for_method_entity class_entity
    raise NotImplementedError
  end
end