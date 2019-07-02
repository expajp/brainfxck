# 命令オブジェクト生成器
class InstructionFatory
	def self.create(inst, inst_seq, byte_seq)
		ret = case inst
			in '>'
				ShiftToRight.new(inst_seq, byte_seq)
			in '<'
				ShiftToLeft.new(inst_seq, byte_seq)
			in '+'
				Increment.new(inst_seq, byte_seq)
			in '-'
				Decrement.new(inst_seq, byte_seq)
			in '.'
				Output.new(inst_seq, byte_seq)
			in ','
				Input.new(inst_seq, byte_seq)
			in '['
				StartBlock.new(inst_seq, byte_seq)
			in ']'
				EndBlock.new(inst_seq, byte_seq)
		end
		ret
	end
end
