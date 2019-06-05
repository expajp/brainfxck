require 'minitest/autorun'
require './brainfxck'

class BrainFxckTest < Minitest::Test
  def test_hello_world
    hello_world_code = <<'HW'
      >+++++++++[<++++++++>-]<.>+++++++[<++++>-]<+.+++++++..+++.[-]>++++++++[<++
      ++>-]<.>+++++++++++[<+++++>-]<.>++++++++[<+++>-]<.+++.------.--------.[-]>
      ++++++++[<++++>-]<+.[-]++++++++++.  
HW
    $stdout = StringIO.new
    BrainFxck.new(hello_world_code).run
    assert_equal "Hello World!\n\n", $stdout.string
  end
end