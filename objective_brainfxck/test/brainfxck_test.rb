require 'minitest/autorun'
require './brainfxck'

class BrainFxckTest < Minitest::Test
  def test_hello_world
    File.open('../sample_codes/hello.bf') do |file|
      $stdout = StringIO.new
      BrainFxck.new(file.read).run
      assert_equal "Hello World!\n\n", $stdout.string
    end
  end
end
