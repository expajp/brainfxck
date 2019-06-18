require './brainfxck'

RSpec.describe InstructionSequence do
  class InstructionSequence
    attr_accessor :pc, :stack
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
      context 'pointed instruction is not left bracket' do
        it 'raise error' do 
          expect{ instruction_sequence.start_block(0) }.to raise_error(BrainFxcks::ProgramError, '現在の命令は"["ではありません') 
        end
      end
      context 'single brackets pair' do
        context 'val is zero' do
          let(:instructions){ '[>+++<]' }
          it 'jump to corresponding right brackets' do 
            instruction_sequence.start_block(0)
            expect(instruction_sequence.pc).to eq 6
          end
        end
        context 'val is not zero' do
          let(:instructions){ '+++[>+++<-]' }
          it 'push program counter' do
            instruction_sequence.pc = 3
            instruction_sequence.start_block(3)
            expect(instruction_sequence.stack[0]).to eq 3
          end
        end
      end
      context 'multiple brackets pair' do
        let(:instructions){ '+++[>+++[>+++++<-]<-]' }
        context 'val is zero' do
          it 'jump to corresponding right brackets for outer' do
            instruction_sequence.pc = 3
            instruction_sequence.start_block(0)
            expect(instruction_sequence.pc).to eq 20
          end
          it 'jump to corresponding right brackets for inner' do
            instruction_sequence.pc = 8
            instruction_sequence.start_block(0)
            expect(instruction_sequence.pc).to eq 17
          end
        end
        context 'val is not zero' do
          it 'push program counter for outer' do
            instruction_sequence.pc = 3
            instruction_sequence.start_block(3)
            expect(instruction_sequence.stack[0]).to eq 3
          end
          it 'push program counter for inner' do
            instruction_sequence.pc = 8
            instruction_sequence.stack = [3]
            instruction_sequence.start_block(3)
            expect(instruction_sequence.stack[1]).to eq 8
          end
        end
      end
    end

    describe 'end_block' do
      context 'pointed instruction is not right bracket' do
        it 'raise error' do 
          expect{ instruction_sequence.end_block(0) }.to raise_error(BrainFxcks::ProgramError, '現在の命令は"]"ではありません') 
        end
      end
      context 'single brackets pair' do
        context 'val is zero' do
          let(:instructions){ '[>+++<]' }
          it 'pop stack' do
            instruction_sequence.pc = 6
            instruction_sequence.stack = [0]
            instruction_sequence.end_block(0)

            expect(instruction_sequence.stack).to eq []
          end          
        end
        context 'val is not zero' do
          context 'stack is empty' do
            let(:instructions){ ']' }
            it 'raise error' do
              expect{ instruction_sequence.end_block(1) }.to raise_error(BrainFxcks::ProgramError, 'スタックに値が入っていません') 
            end
          end
          context 'stack is not empty' do
            let(:instructions){ '+++[>+++<-]' }
            it 'jump to corresponding left bracket' do
              instruction_sequence.pc = 10
              instruction_sequence.stack = [3]
              instruction_sequence.end_block(2)

              expect(instruction_sequence.pc).to eq 3
            end
          end
        end
      end
      context 'multiple brackets pair' do
        let(:instructions){ '+++[>+++[>+++++<-]<-]' }
        context 'val is zero' do
          it 'pop stack for outer' do
            instruction_sequence.pc = 20
            instruction_sequence.stack = [3]
            instruction_sequence.end_block(0)

            expect(instruction_sequence.pc).to eq 20
            expect(instruction_sequence.stack).to eq []
          end
          it 'pop stack for inner' do
            instruction_sequence.pc = 17
            instruction_sequence.stack = [3, 8]
            instruction_sequence.end_block(0)

            expect(instruction_sequence.pc).to eq 17
            expect(instruction_sequence.stack).to eq [3]
          end
        end
        context 'val is not zero' do
          it 'jump to corresponding left bracket for outer' do
            instruction_sequence.pc = 20
            instruction_sequence.stack = [3]
            instruction_sequence.end_block(2)

            expect(instruction_sequence.pc).to eq 3
            expect(instruction_sequence.stack).to eq [3]
          end
          it 'jump to corresponding left bracket for inner' do
            instruction_sequence.pc = 17
            instruction_sequence.stack = [3, 8]
            instruction_sequence.end_block(2)

            expect(instruction_sequence.pc).to eq 8
            expect(instruction_sequence.stack).to eq [3, 8]
          end
        end
      end
    end
  end
end
