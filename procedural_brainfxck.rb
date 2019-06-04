# 実行方法
# $ ruby procedural_brainfxck.rb <sample_codes/hello.bf

begin 
	# 命令の定義
	INSTRUCTIONS = ['>','<','+','-','.',',','[',']']

	# ソースコード読み込み
	src = $stdin.read
	
	# ソースコードを命令列に変換
	scanner = Regexp.new(INSTRUCTIONS.map{ |c| Regexp.escape(c) }.join('|'))
	inst_seq = src.scan(scanner).flatten

	# 命令スタックとプログラムカウンタを初期化
	inst_stack = Array.new
	pc = 0

	# バイト列、バイトスタック、バイトポインタの初期化
	byte_seq = [0]
	byte_stack = Array.new
	byte_pointer = 0

	# 出力の初期化
	output = ''

	# 処理の実行
	loop do
		inst = inst_seq[pc]
		case inst
			when '>'
				# ポインタをインクリメント
				byte_pointer += 1
			when '<'
				# ポインタをデクリメント
				raise ProgramError, '0未満のポインタを指定することはできません' if byte_pointer <= 0
				byte_pointer -= 1
			when '+'
				# バイト列をインクリメント
				byte_seq[byte_pointer] = 0 if byte_seq[byte_pointer].nil?
				byte_seq[byte_pointer] += 1
			when '-'
				# バイト列をデクリメント
				byte_seq[byte_pointer] = 0 if byte_seq[byte_pointer].nil?
				raise ProgramError, '0未満のデータを持つことはできません' if byte_seq[byte_pointer] == 0
				byte_seq[byte_pointer] -= 1
			when '.'
				output += (byte_seq[byte_pointer] || 0).chr('UTF-8')
			when ','
				# 未実装
			when '['
				if byte_seq[byte_pointer] == 0 # 参照データの値が0ならば、対応する]にジャンプ
					stride = inst_seq[pc..-1].index(']')
					raise ProgramError, '"["に対応する"]"が見つかりません' if stride.nil?
					pc = pc + stride + 1
				else # 参照データの値が0ならば、現在の命令ポインタをスタックに保持
					inst_stack.push(pc)
				end
			when ']'
				if byte_seq[byte_pointer] == 0 # 参照データの値が0ならば、スタックの末尾を削除
					raise ProgramError, 'スタックに値が入っていません' if inst_stack.empty?
					inst_stack.pop
				else # 参照データの値が0でないなら、スタックに入っている箇所に戻る
					raise ProgramError, 'スタックに値が入っていません' if inst_stack.empty?
					pc = inst_stack.last
				end
		end
		pc += 1 # 命令を次に進める
		break if inst_seq.length <= pc # ファイルの終端なら終了
	end
	print output # 結果を出力
rescue 
  puts "プログラムの実行に失敗しました"
end
