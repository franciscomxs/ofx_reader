require 'spec_helper'

RSpec.describe OFXReader::Parser::Base do
  context 'OFX version 102' do
    let(:parser) { OFXReader::Parser::Base.new(file_fixture('sample.ofx').read) }

    describe '#headers' do
      it { expect(parser.headers[:ofxheader]).to eq("100") }
      it { expect(parser.headers[:data]).to eq("OFXSGML") }
      it { expect(parser.headers[:version]).to eq("102") }
      it { expect(parser.headers[:security]).to eq("TYPE1") }
      it { expect(parser.headers[:encoding]).to eq("USASCII") }
      it { expect(parser.headers[:charset]).to eq("1252") }
      it { expect(parser.headers[:compression]).to eq("NONE") }
      it { expect(parser.headers[:oldfileuid]).to eq("NONE") }
      it { expect(parser.headers[:newfileuid]).to eq("NONE") }
    end

    describe '#account' do
      it { expect(parser.account[:acctid]).to eq('000000') }
      it { expect(parser.account[:bankid]).to eq('000') }
      it { expect(parser.account[:accttype]).to eq('CHECKING') }
    end

    describe '#transactions' do
      it { expect(parser.transactions).to be_a(Array) }
      it { expect(parser.transactions).to be_a_list_of(Hash) }
      it { expect(parser.transactions.first[:trntype]).to eq("DEBIT") }
      it { expect(parser.transactions.first[:dtposted]).to eq('20090209000000[-5:EST]') }
      it { expect(parser.transactions.first[:trnamt]).to eq('-98.91') }
      it { expect(parser.transactions.first[:fitid]).to eq("00000000000000000000000000") }
      it { expect(parser.transactions.first[:name]).to eq("GROCER A  Z") }
    end
  end

  context 'unsupported of version' do
    let(:headers) { { version: '1' } }
    let(:sample) { file_fixture('sample.ofx').read }

    before do
      allow_any_instance_of(OFXReader::Parser::Base).to \
        receive(:headers).and_return(headers)
    end

    it 'raise UnsupportedOFXVersionError for invalid OFX version' do
      expect {
        OFXReader::Parser::Base.new(sample)
      }.to raise_error(OFXReader::UnsupportedOFXVersionError)
    end
  end
end
