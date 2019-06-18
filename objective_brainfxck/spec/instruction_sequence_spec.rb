require './brainfxck'

RSpec.describe InstructionSequence do
  class InstructionSequence
    attr_accessor :pc
  end

  describe 'unit tests' do
    let(:instructions){ '+-+++[>+++<]' }
    let(:instruction_sequence){ InstructionSequence.new(instructions) }

    it 'fetch' do
      expect(instruction_sequence.fetch).to eq '+'
    end

    it 'raise error when overrun' do
      instruction_sequence.pc = instructions.length
      expect{ instruction_sequence.fetch }.to raise_error(BrainFxcks::ProgramError, 'プログラムカウンタが命令列サイズを超過しています') 
    end

    it 'next_inst' do
      expect{ instruction_sequence.next_inst }.to change{ instruction_sequence.fetch }.from('+').to('-')
    end

    describe 'eof?' do
      it 'returns true' do
        instructions.length.times { instruction_sequence.next_inst }
        expect(instruction_sequence.eof?).to eq true
      end

      it 'returns false' do
        expect(instruction_sequence.eof?).to eq false
      end
    end

    describe 'start_block' do
      context 'val is zero' do
        it 'returns pc of endblock' do 
        end
      end      
    end

    it 'end_block' do
    end
  end
end
