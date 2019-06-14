require './brainfxck.rb'

RSpec.describe BrainFxck do
  describe 'run sample codes' do
    before do 
      $stdout = StringIO.new
      File.open('../sample_codes/hello.bf') do |file|
        BrainFxck.new(file.read).run
      end
    end

    describe 'display hello_world' do
      let(:source_path){ '../sample_codes/hello.bf' }

      it 'display hello_world' do
        expect($stdout.string).to eq "Hello World!\n\n"
      end
    end

  end
end
