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

  def test_fizzbuzz
    File.open('../sample_codes/fizzbuzz.bf') do |file|
      $stdout = StringIO.new
      BrainFxck.new(file.read).run
      fizzbuzz = (1..100).to_a.map{ |n| n%3 == 0 ? (n%5 == 0 ? 'FizzBuzz' : 'Fizz') : (n%5 == 0 ? 'Buzz' : n.to_s) }.join(' ')
      assert_equal "#{fizzbuzz}\n\n", $stdout.string
    end
  end
end
