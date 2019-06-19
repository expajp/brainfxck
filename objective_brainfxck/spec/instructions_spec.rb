require './brainfxck'

RSpec.describe AbstructInstruction do
  class ByteSequence
    attr_accessor :p, :seq
  end
  class InstructionSequence
    attr_accessor :pc, :stack
  end

  describe 'unit tests' do
    let(:inst_seq){ InstructionSequence.new('+++[>+++[>+++++<-]<-]') }
    let(:byte_seq){ ByteSequence.new }

    def run
      inst = inst_class.new(inst_seq, byte_seq)
      inst_seq, byte_seq = inst.run
    end

    describe 'ShiftToRight' do
      let(:inst_class){ ShiftToRight }
      it 'shift pointer to right' do
        allow(byte_seq).to receive(:right)
        run
        expect(byte_seq).to have_received(:right).once
      end
    end
    
    describe 'ShiftToLeft' do
      let(:inst_class){ ShiftToLeft }
      it 'shift pointer to left' do
        allow(byte_seq).to receive(:left)
        run
        expect(byte_seq).to have_received(:left).once
      end
    end
    
    describe 'Increment' do
      let(:inst_class){ Increment }
      it 'increment value' do
        allow(byte_seq).to receive(:increment)
        run
        expect(byte_seq).to have_received(:increment).once
      end
    end
    
    describe 'Decrement' do
      let(:inst_class){ Decrement }
      it 'decrement value' do
        allow(byte_seq).to receive(:decrement)
        run
        expect(byte_seq).to have_received(:decrement).once
      end
    end
    
    describe 'Output' do
      let(:inst_class){ Output }
      it 'output value by char' do
        allow(byte_seq).to receive(:val_by_char)
        run
        expect(byte_seq).to have_received(:val_by_char).once
      end
    end
    
    describe 'Input' do
      let(:inst_class){ Input }
      it 'input string from stdin' do
        $stdin = StringIO.new('A')
        input = Input.new(inst_seq, byte_seq)
        inst_seq, byte_seq = input.run
        expect(byte_seq.seq[byte_seq.p]).to eq 65
      end
    end
    
    describe 'StartBlock' do
      let(:inst_class){ StartBlock }
      it 'calls start_block of instruction sequence' do
        allow(inst_seq).to receive(:start_block)
        run
        expect(inst_seq).to have_received(:start_block).once
      end
    end
    
    describe 'EndBlock' do
      let(:inst_class){ EndBlock }
      it 'calls end_block of instruction sequence' do
        allow(inst_seq).to receive(:end_block)
        run
        expect(inst_seq).to have_received(:end_block).once
      end
    end


  end
end
