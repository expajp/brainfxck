class AbstructInstruction
	def run(inst_seq, byte_seq)
		raise ProgramError, '命令クラスを実装してください'
	end
end

class ShiftToRight < AbstructInstruction
	def run(inst_seq, byte_seq)
		byte_seq.right
		[inst_seq, byte_seq]
	end
end
class ShiftToLeft < AbstructInstruction
	def run(inst_seq, byte_seq)
		byte_seq.left
		[inst_seq, byte_seq]
	end
end
class Increment < AbstructInstruction
	def run(inst_seq, byte_seq)
		byte_seq.increment
		[inst_seq, byte_seq]
	end
end
class Decrement < AbstructInstruction
	def run(inst_seq, byte_seq)
		byte_seq.decrement
		[inst_seq, byte_seq]
	end
end
class Output < AbstructInstruction
	def run(inst_seq, byte_seq)
		print byte_seq.val_by_char
		[inst_seq, byte_seq]
	end
end
class Input < AbstructInstruction
	def run(inst_seq, byte_seq)
		byte_seq.val = $stdin.gets
		[inst_seq, byte_seq]
	end
end
class StartBlock < AbstructInstruction
	def run(inst_seq, byte_seq)
		inst_seq.start_block(byte_seq.val)
		[inst_seq, byte_seq]
	end
end
class EndBlock < AbstructInstruction
	def run(inst_seq, byte_seq)
		inst_seq.end_block(byte_seq.val)
		[inst_seq, byte_seq]
	end
end
