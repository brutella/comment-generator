require_relative '../base/code'

class RubyCode < Code
  def initialze string
    super string
    @entities << :RubyClass
  end
end