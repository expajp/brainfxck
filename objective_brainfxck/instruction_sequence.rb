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
		if val == 0
			jump_to_endblock
		else
			@stack.push(@pc)
		end
	end

	# ']'に対する処理
	def end_block(val)
		if val == 0
			raise BrainFxcks::ProgramError, 'スタックに値が入っていません' if @stack.empty?
			@stack.pop
		else
			jump_to_startblock
		end
	end

	private

	def jump_to_endblock
		counter = @pc
		st = []
		loop do
			counter += 1
			if st.empty? && @seq[counter] == ']'
				break
			elsif @seq[counter] == ']'
				st.pop
			elsif @seq[counter] == '['
				st.push(counter)
			elsif eof?
				raise BrainFxcks::ProgramError, '対応する]がありません'
			end
		end
		@pc = counter + 1
	end

	def jump_to_startblock
		raise BrainFxcks::ProgramError, 'スタックに値が入っていません' if @stack.empty?
		@pc = @stack.last
	end
end
