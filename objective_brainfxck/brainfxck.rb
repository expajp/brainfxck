# 実行方法
# $ ruby brainfxck.rb <../sample_codes/hello.bf

require './instructions'
require './instruction_sequence'
require './byte_sequence'

class BrainFxck
	class ProgramError < StandardError; end

	def initialize(src)
		@inst_seq = InstructionSequence.new(src)
		@byte_seq = ByteSequence.new
	end

	def run
		loop do
			inst = @inst_seq.fetch
			@inst_seq, @byte_seq = inst.run(@inst_seq, @byte_seq)
			# for debug
			# @inst_seq.view
			# @byte_seq.view
			@inst_seq.next_inst
			break if @inst_seq.eof?
		end
		print "\n"
	end
end

begin 
  BrainFxck.new($stdin.read).run
rescue BrainFxck::ProgramError => e
  puts e.message
  puts "プログラムの実行に失敗しました"
end
