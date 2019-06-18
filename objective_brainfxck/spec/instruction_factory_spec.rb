require './brainfxck'

RSpec.describe InstructionFatory do
  describe 'unit tests' do
    let(:instructions){ '+-+++[>+++<]' }
    let(:inst_seq){ InstructionSequence.new instructions }
    let(:byte_seq){ ByteSequence.new }
    let(:instruction_obj){ InstructionFatory.create(inst, inst_seq, byte_seq) }

    context '>' do
      let(:inst){ '>' }
      it 'returns valid object' do
        expect(instruction_obj.class.name).to eq 'ShiftToRight'
      end
    end

    context '<' do
      let(:inst){ '<' }
      it 'returns valid object' do
        expect(instruction_obj.class.name).to eq 'ShiftToLeft'
      end
    end

    context '+' do
      let(:inst){ '+' }
      it 'returns valid object' do
        expect(instruction_obj.class.name).to eq 'Increment'
      end
    end

    context '-' do
      let(:inst){ '-' }
      it 'returns valid object' do
        expect(instruction_obj.class.name).to eq 'Decrement'
      end
    end

    context '.' do
      let(:inst){ '.' }
      it 'returns valid object' do
        expect(instruction_obj.class.name).to eq 'Output'
      end
    end

    context ',' do
      let(:inst){ ',' }
      it 'returns valid object' do
        expect(instruction_obj.class.name).to eq 'Input'
      end
    end

    context '[' do
      let(:inst){ '[' }
      it 'returns valid object' do
        expect(instruction_obj.class.name).to eq 'StartBlock'
      end
    end

    context ']' do
      let(:inst){ ']' }
      it 'returns valid object' do
        expect(instruction_obj.class.name).to eq 'EndBlock'
      end
    end

    context 'other inst' do
      let(:inst){ 'a' }
      it 'returns valid object' do
        expect{ instruction_obj }.to raise_error(BrainFxcks::ProgramError, '既定の命令以外が渡されました')
      end
    end

  end
end
