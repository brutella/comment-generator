# Represents a code in a specific programming language
# 
# This class encapsulates a code, in a specific language.
# The comments are generated based on the comment syntax
# 
class Code
  attr_accessor :string_representation
  attr_accessor :generated_string
  attr_accessor :entities
  attr_accessor :comment_syntax
  
  # initialize
  # 
  # [string]            String representation of a code block. (eg. string of file)
  # [language_entities] Programming language entites for which comments should be generated
  # [comment_syntax]    The syntax in which the comments should be generated
  # 
  def initialize string, language_entities, comment_syntax
    @string_representation = string
    @generated_string = String.new
    @entities = language_entities
    @comment_syntax = comment_syntax
  end
  
  # Parses the code to find commentable entities
  # 
  # Parses each line of the code to find commentable entites.
  # If an entity is already commented in the specified comment syntax,
  # no comment is generated. The commented code is saved in the 
  # @generated_string string attribute.
  # 
  def parse_code
    already_documented = false  
    @string_representation.each_line do |line|
      @entities.each do |entity_class|
        already_documented  = already_documented || @comment_syntax.commentStart?(line)
        begin
          entity = Object.const_get(entity_class).new line, @comment_syntax
          if already_documented
            already_documented = false
          else
            generated_string << entity.comment_string + "\n"  
          end
        rescue
        end
      end
      generated_string << line
    end
  end
  
end