class ByteSequence
	class ProgramError < StandardError; end

	def initialize
		@seq = [0]
		@stack = Array.new
		@p = 0
	end

	# ポインタをインクリメントする
	def right
		@p += 1
	end

	# ポインタをデクリメントする
	def left
		raise BrainFxcks::ProgramError, '0未満のポインタを指定することはできません' if @p <= 0
		@p -= 1
	end

	# 値をインクリメントする
	def increment
		@seq[@p] = 0 if @seq[@p].nil?
		@seq[@p] += 1
	end

	# 値をデクリメントする
	def decrement
		@seq[@p] = 0 if @seq[@p].nil?
		raise BrainFxcks::ProgramError, '0未満のデータを持つことはできません' if @seq[@p] == 0
		@seq[@p] -= 1
	end

	# 現在位置の値を取得
	def val
		@seq[@p] ||= 0
	end

	# 現在位置の値を上書き
	def val=(v)
		@seq[@p] = v
	end

	# 現在位置の値を文字として取得
	def val_by_char
		val.chr('UTF-8')
	end
end
