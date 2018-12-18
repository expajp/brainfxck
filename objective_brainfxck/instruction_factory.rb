# 命令オブジェクト生成器
class InstructionFatory
	def self.create(inst, inst_seq, byte_seq)
		ret = case inst
			when '>'
				ShiftToRight.new(inst_seq, byte_seq)
			when '<'
				ShiftToLeft.new(inst_seq, byte_seq)
			when '+'
				Increment.new(inst_seq, byte_seq)
			when '-'
				Decrement.new(inst_seq, byte_seq)
			when '.'
				Output.new(inst_seq, byte_seq)
			when ','
				Input.new(inst_seq, byte_seq)
			when '['
				StartBlock.new(inst_seq, byte_seq)
			when ']'
				EndBlock.new(inst_seq, byte_seq)
		end
		ret
	end
end
