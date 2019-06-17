require './brainfxck.rb'

RSpec.describe ByteSequence do
  class ByteSequence
    attr_accessor :p
  end
  
  describe 'unit tests' do
    let(:byte_sequence){ ByteSequence.new }
    it 'right' do
      expect{ byte_sequence.right }.to change{ byte_sequence.p }.by(1)
    end
    
    it 'left' do
      byte_sequence.right
      expect{ byte_sequence.left }.to change{ byte_sequence.p }.by(-1)
    end
    
    it 'raise error by left when pointer is zero' do
      expect{ byte_sequence.left }.to raise_error(BrainFxcks::ProgramError, '0未満のポインタを指定することはできません')
    end

    it 'increment' do
      expect{ byte_sequence.increment }.to change{ byte_sequence.val }.by(1)
    end
    
    it 'decrement' do
      byte_sequence.increment
      expect{ byte_sequence.decrement }.to change{ byte_sequence.val }.by(-1)
    end
    
    it 'raise error by decrement when val is zero' do
      expect{ byte_sequence.decrement }.to raise_error(BrainFxcks::ProgramError, '0未満のデータを持つことはできません')
    end

    it 'val' do
      random = rand(10)+1
      random.times{ byte_sequence.increment }

      expect(byte_sequence.val).to eq random
    end
  
    it 'val=(v)' do
      random = rand(10)+1
      random.times{ byte_sequence.increment }
      byte_sequence.val = 11

      expect(byte_sequence.val).to eq 11
    end

    it 'raise error by val=(v) when set negative number as argument' do
      expect{ byte_sequence.val = -1 }.to raise_error(BrainFxcks::ProgramError, '0未満のデータを持つことはできません')
    end

    it 'val_by_char' do
      byte_sequence.val = 65
      expect(byte_sequence.val_by_char).to eq 'A'
    end
  end
end
