require 'pry'
class Car
  attr_accessor :wheels, :name
  
  def initialize
    @wheels = 4
  end
  
  def ==(other)
    name == other.name
  end
end