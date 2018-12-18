class AbstructInstruction
	def initialize(inst_seq, byte_seq)
		@inst_seq = inst_seq
		@byte_seq = byte_seq
	end

	def run
		process
		[@inst_seq, @byte_seq]
	end

	def process
		raise ProgramError, '命令クラスを実装してください'
	end
end

class ShiftToRight < AbstructInstruction
	def process
		@byte_seq.right		
	end
end
class ShiftToLeft < AbstructInstruction
	def process
		@byte_seq.left
	end
end
class Increment < AbstructInstruction
	def process
		# TODO
	end
end
class Decrement < AbstructInstruction
	def process
		@byte_seq.decrement
	end
end
class Output < AbstructInstruction
	def process
		print @byte_seq.val_by_char
	end
end
class Input < AbstructInstruction
	def process
		@byte_seq.val = $stdin.gets
	end
end
class StartBlock < AbstructInstruction
	def process
		@inst_seq.start_block(@byte_seq.val)
	end
end
class EndBlock < AbstructInstruction
	def process
		@inst_seq.end_block(@byte_seq.val)
	end
end
