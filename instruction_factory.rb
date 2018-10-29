# 命令オブジェクト生成器
class InstructionFatory
	def create(inst)
		ret = case inst
			when '>'
				ShiftToRight.new
			when '<'
				ShiftToLeft.new
			when '+'
				Increment.new
			when '-'
				Decrement.new
			when '.'
				Output.new
			when ','
				Input.new
			when '['
				StartBlock.new
			when ']'
				EndBlock.new
		end
		ret
	end
end
