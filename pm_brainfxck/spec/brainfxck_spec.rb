require './brainfxck.rb'
require 'prime'

RSpec.describe BrainFxck do
  describe 'run sample codes' do
    before do 
      $stdout = StringIO.new
      File.open(source_path) do |file|
        BrainFxck.new(file.read).run
      end
    end

    describe 'display hello_world' do
      let(:source_path){ '../sample_codes/hello.bf' }

      it 'return Hello World!' do
        expect($stdout.string).to eq "Hello World!\n"
      end
    end

    describe 'display fizzbuzz' do
      let(:source_path){ '../sample_codes/fizzbuzz.bf' }

      it 'display fizzbuzz' do
        answer = (1..100).to_a.map{ |n| "\u0001" + (n%3 == 0 ? (n%5 == 0 ? 'FizzBuzz' : 'Fizz') : (n%5 == 0 ? 'Buzz' : n.to_s)) }
        expect($stdout.string).to eq answer.join(' ') + ' '
      end
    end

    describe 'display primes' do
      let(:source_path){ '../sample_codes/pucci.bf' }

      it 'display primes' do
        answer = (1..100).to_a.select{ |n| n.prime? }
        expect($stdout.string).to eq answer.join(' ')
      end
    end

  end
end
