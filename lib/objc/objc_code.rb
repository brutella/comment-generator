require_relative '../base/code'
require_relative 'objc_class'
require_relative 'objc_method'

# (ObjCCodeCode brief description)
# 
# (Comprehensive description)
# 
class ObjCCode < Code
  # (initialize brief description)
  # 
  # (Comprehensive description)
  # 
  # [code_string] 
  # [comment_syntax] 
  # 
  def initialize code_string, comment_syntax
    entities = []
    entities << :ObjCClass
    entities << :ObjCMethod
    
    super code_string, entities, comment_syntax
  end
end