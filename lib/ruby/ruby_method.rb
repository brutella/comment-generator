require_relative "../base/method_entity"
require_relative "../rdoc/rdoc"
# Example
# def some_method(value='default', arr=[])

class RubyMethod < MethodEntity
    attr_accessor :indentation
    
    def initialize string, syntax
      super string, syntax
      
      @regex_representation = /
                  ^\s*                # Start of the line and optional space
                  def\s+              # def
                  [a-z][a-zA-Z0-9\_]*   # method name
                  \s*(\()?            # space or bracket
                  \s*[[a-z][a-zA-Z0-9\_]*\s*\,]*
                  (\))?                # optional bracket 
                /x                    # Ignore whitespaces between regex tokens                
      raise ArgumentError, "String doesn't contain an Ruby method definition" if !matches_with_string(@definition)
      
      initialize_from_definition
    end
    
    def initialize_from_definition  
      @indentation = @definition.scan(/^(\s*)def/).join
      @name = @definition.scan(/^\s*def\s+([a-z][a-zA-Z0-9\_]*)/).join
      param_names = Array.new
      values = @definition.split " "
      while values.shift.eql?(@name) == false do
      end
      
      values.map!{ |str| str.gsub(/[\r\n\s\,]/, "") }
      
      @param_names = values
    end
    
    # Override
    def comment_string
      comment = @comment_syntax.string_for_method_entity self
      indented_comment = ""
      comment.each_line{ |line| indented_comment << @indentation + line }

      indented_comment
    end
end