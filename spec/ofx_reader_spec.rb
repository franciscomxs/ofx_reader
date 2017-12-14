RSpec.describe OFXReader do
  it "has a version number" do
    expect(OFXReader::VERSION).to eq('0.1.3')
  end

  describe '.call' do
    let(:sample) { file_fixture('sample.ofx').read }

    it 'is a shortcut to OFXReader::Parser::Base' do
      expect(OFXReader::Parser::Base).to receive(:new).with(sample).once
      OFXReader.(sample)
    end
  end
end
