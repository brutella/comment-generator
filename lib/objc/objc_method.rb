require_relative '../base/method_entity'
require_relative "../doxygen/doxygen"

# (ObjCMethodMethodEntity brief description)
# 
# (Comprehensive description)
# 
class ObjCMethod < MethodEntity    

  # (self.maybeCommentString? brief description)
  # 
  # (Comprehensive description)
  # 
  # [string] 
  # 
  def self.maybeCommentString? string
    doxygen_start_regex = /\/\*\*/
    return !string[doxygen_start_regex].nil?                
  end
  
  # (initialize brief description)
  # 
  # (Comprehensive description)
  # 
  # [string] 
  # [syntax] 
  # 
  def initialize string, syntax
    super string, syntax
    @regex_representation = /
                 ^\s*                # Start of the line and optional space
                 [+-]\s*             # a plus or minus for method specifier
                 \([^)]+\)           # the return type in brackets
                 ((?:\n|[^@{])*)     
                 (?m:[\s;]*)                          
               /x                    # Ignore whitespaces between regex tokens                
               
    raise ArgumentError, "String doesn't contain an Objective-C method definition" unless matches_with_string @definition
    
    initialize_from_definition
  end
  def initialize_from_definition
    found_method = @definition[@regex_representation]

    exit if found_method.nil? or found_method.empty?
    
    @name = @definition.scan(/([^\s^\(^\)]+\:)/).join
    param_names = Array.new 
    @definition.scan(/\)([^\)^\s^\(^\-^\+^\;^\{^\:]+)/){ |temp| param_names << temp.shift }
    param_names.shift # Remove name of first parameter
    @param_names = param_names
    
    param_types = Array.new    
    @definition.scan(/\(([^\)]+)\)/).map { |temp| param_types << temp.shift }
    @return_value = param_types.shift.to_s
    @param_types = param_types
  end
end