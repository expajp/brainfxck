$:.unshift File.dirname(__FILE__)

require 'minitest/autorun'
require '../objective_brainfxck/brainfxck'

hello_world_code = <<HW
  >+++++++++[<++++++++>-]<.>+++++++[<++++>-]<+.+++++++..+++.[-]>++++++++[<++
  ++>-]<.>+++++++++++[<+++++>-]<.>++++++++[<+++>-]<.+++.------.--------.[-]>
  ++++++++[<++++>-]<+.[-]++++++++++.  
HW

class BrainFxckTest < Minitest::Test
  def hello_world
    assert_equal BrainFxck.new(hello_world_code).run, "Hello World!\n"
  end
end