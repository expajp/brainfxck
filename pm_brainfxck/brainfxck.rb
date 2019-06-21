module BrainFxcks
	class ProgramError < StandardError; end
end

class BrainFxck
	def initialize(src)
		@src = src
	end

	def run
	end
end
