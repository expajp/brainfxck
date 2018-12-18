# 実行方法
# $ ruby brainfxck.rb <../sample_codes/hello.bf

module BrainFxcks
	class ProgramError < StandardError; end
end

require './instructions'
require './instruction_sequence'
require './byte_sequence'

class BrainFxck
	def initialize(src)
		@inst_seq = InstructionSequence.new(src)
		@byte_seq = ByteSequence.new
	end

	def run
		loop do
			inst = @inst_seq.fetch
			inst_obj = InstructionFatory.create(inst, @inst_seq, @byte_seq)
			@inst_seq, @byte_seq = inst_obj.run
			@inst_seq.next_inst
			break if @inst_seq.eof?
		end
		print "\n"
	end
end

begin 
  BrainFxck.new($stdin.read).run
rescue BrainFxcks::ProgramError => e
	puts e.message
  puts "プログラムの実行に失敗しました"
end
