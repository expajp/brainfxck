require './byte_sequence.rb'

RSpec.describe ByteSequence do
  class ByteSequence
    attr_accessor :p
  end
  
  describe 'unit tests' do
    it 'right' do
      byte_sequence = ByteSequence.new
      expect{ byte_sequence.right }.to change{ byte_sequence.p }.by(1)
    end
  end
end
