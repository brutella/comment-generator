class Code
  attr_accessor :string_representation
  attr_accessor :generated_string
  attr_accessor :entities
  
  def initialize string, language_entities = []
    @string_representation = string
    @generated_string = String.new
    @entities = language_entities
  end
  
  def parse_code
    already_documented = false
    string.each_line do |line|
      @entityClasses.each do |entity_class|
        already_documented  = already_documented || Object.const_get(entity_class).maybeCommentString?(line)
        
        begin
          entity = Object.const_get(entity_class).new line
          if already_documented
            already_documented = false
          else
            # TODO: inject comment string behaviour
            generated_string << entity.comment_string + "\n"  
          end
        rescue
        end
      end
            
      generated_string << line
  end
  
end