require './instruction_factory'

# 命令列オブジェクト
class InstructionSequence
	class ProgramError < StandardError; end

	INSTRUCTIONS = ['>','<','+','-','.',',','[',']']

	def initialize(src)
		scanner = Regexp.new(INSTRUCTIONS.map{ |c| Regexp.escape(c) }.join('|'))
		@seq = src.scan(scanner).flatten
		@stack = Array.new
		@pc = 0
	end

	# 次の命令を取り出して返す
	def fetch
		inst = @seq[@pc]
		raise BrainFxcks::ProgramError, 'プログラムカウンタが命令列サイズを超過しています' if inst.nil?
		inst
	end

	# pcを進める
	def next_inst		
		@pc += 1
	end

	# 命令ポインタが命令列の終端にあるか
	def eof?
		return true if @seq.length <= @pc
		false
	end

	# '[' に対する処理
	def start_block(val)
		raise BrainFxcks::ProgramError, '現在の命令は"["ではありません' if @seq[@pc] != '['
		jump_to_endblock and return if val == 0
		@stack.push(@pc)
	end
	
	# ']'に対する処理
	def end_block(val)
		raise BrainFxcks::ProgramError, '現在の命令は"]"ではありません' if @seq[@pc] != ']'
		if val == 0
			raise BrainFxcks::ProgramError, 'スタックに値が入っていません' if @stack.empty?
			@stack.pop and return
		end
		jump_to_startblock
	end

	private

	def jump_to_endblock
		st = []
		loop do
			@pc += 1
			if st.empty? && @seq[@pc] == ']'
				break
			elsif @seq[@pc] == ']'
				st.pop
			elsif @seq[@pc] == '['
				st.push(@pc)
			elsif eof?
				raise BrainFxcks::ProgramError, '対応する]がありません'
			end
		end
	end

	def jump_to_startblock
		raise BrainFxcks::ProgramError, 'スタックに値が入っていません' if @stack.empty?
		@pc = @stack.last
	end
end
