require_relative '../base/code'
require_relative 'ruby_class'
require_relative 'ruby_method'

# (RubyCodeCode brief description)
# 
# (Comprehensive description)
# 
class RubyCode < Code
  # (initialize brief description)
  # 
  # (Comprehensive description)
  # 
  # [code_string] 
  # [comment_syntax] 
  # 
  def initialize code_string, comment_syntax
    entities = []
    entities << :RubyClass
    entities << :RubyMethod
    
    super code_string, entities, comment_syntax
  end
end