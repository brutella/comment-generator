class Code
  attr_accessor :string_representation
  attr_accessor :generated_string
  attr_accessor :entities
  attr_accessor :comment_syntax
  
  def initialize string, language_entities, comment_syntax
    @string_representation = string
    @generated_string = String.new
    @entities = language_entities
    @comment_syntax = comment_syntax
  end
  
  def parse_code
    already_documented = false  
    @string_representation.each_line do |line|
      puts line
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