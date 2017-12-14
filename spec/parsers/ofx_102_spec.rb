require 'spec_helper'

RSpec.describe OFXReader::Parser::OFX102 do
  let(:parser) {
    OFXReader::Parser::OFX102.new(file_fixture('sample.ofx').read)
  }

  describe '#account' do
    subject { parser.account }
    it { is_expected.to eq({ account_id: '000000', bank_id: '000000000' }) }
  end

  describe '#transactions' do
    subject { parser.transactions }
    it { is_expected.to be_a(Array) }
    it { is_expected.to be_a_list_of(Hash) }

    it do
      expect(subject.first).to eq({
        trntype: "DEBIT",
        dtposted: '20090209000000[-5:EST]',
        trnamt: '-98.91',
        fitid: "00000000000000000000000000",
        name: "GROCER A  Z"
      })
    end
  end
end
