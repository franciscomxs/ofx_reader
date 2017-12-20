require 'spec_helper'

RSpec.describe OFXReader do
  context 'full read' do
    let!(:ofx) { OFXReader.(file_fixture('nubank.ofx').read) }
    it { expect(ofx.headers[:ofxheader]).to eq('100') }
    it { expect(ofx.headers[:data]).to eq('OFXSGML') }
    it { expect(ofx.headers[:version]).to eq('102') }
    it { expect(ofx.headers[:security]).to eq('NONE') }
    it { expect(ofx.headers[:encoding]).to eq('USASCII') }
    it { expect(ofx.headers[:charset]).to eq('1252') }
    it { expect(ofx.headers[:compression]).to eq('NONE') }
    it { expect(ofx.headers[:oldfileuid]).to eq('NONE') }
    it { expect(ofx.headers[:newfileuid]).to eq('NONE') }

    it { expect(ofx.account).to eq({}) }

    it { expect(ofx.transactions.count).to eq(3) }
    it { expect(ofx.transactions.first[:trntype]).to eq('DEBIT') }
    it { expect(ofx.transactions.first[:dtposted]).to eq('20170901000000[-3:GMT]') }
    it { expect(ofx.transactions.first[:trnamt]).to eq('-40.00') }
    it { expect(ofx.transactions.first[:fitid]).to eq('12345678-1234-1234-1234-ab1234567890') }
    it { expect(ofx.transactions.first[:memo]).to eq('Netflix') }
  end

  context 'strict' do
    it {
      expect {
         OFXReader.(file_fixture('nubank.ofx').read, strict: true)
       }.to raise_error(OFXReader::OFXWithoutBankAccountError)
    }
  end
end
