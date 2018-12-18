require './instruction_factory'

# 命令列オブジェクト
class InstructionSequence
	INSTRUCTIONS = ['>','<','+','-','.',',','[',']']

	def initialize(src)
		scanner = Regexp.new(INSTRUCTIONS.map{ |c| Regexp.escape(c) }.join('|'))
		@seq = src.scan(scanner).flatten
		@stack = Array.new
		@pc = 0
	end

	# 次の命令を取り出して返す
	def fetch
		@seq[@pc]
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
			raise ProgramError, 'スタックに値が入っていません' if @stack.empty?
			@stack.pop
		else
			jump_to_startblock
		end
	end

	def view
		p "stack: #{@stack}"
		p "pc: #{@pc}/#{@seq.length}"
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
				raise ProgramError, '対応する]がありません'
			end
		end
		@pc = counter + 1
	end

	def jump_to_startblock
		raise ProgramError, 'スタックに値が入っていません' if @stack.empty?
		@pc = @stack.last
	end
end
