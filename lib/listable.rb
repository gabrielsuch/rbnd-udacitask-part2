module Listable
  attr_reader :description

  def format_description
    "#{@description}".ljust(25)
  end
end
