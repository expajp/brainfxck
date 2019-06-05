# 実行方法
# $ ruby entrypoint.rb <../sample_codes/hello.bf

require './brainfxck'

begin 
  BrainFxck.new($stdin.read).run
rescue BrainFxcks::ProgramError => e
	puts e.message
  puts "プログラムの実行に失敗しました"
end
