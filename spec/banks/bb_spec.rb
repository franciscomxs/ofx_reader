require 'spec_helper'

RSpec.describe OFXReader do
  context 'example 01' do
    let!(:ofx) { OFXReader.(file_fixture('bb01.ofx').read) }
    it { expect(ofx.headers[:ofxheader]).to eq('100') }
    it { expect(ofx.headers[:data]).to eq('OFXSGML') }
    it { expect(ofx.headers[:version]).to eq('102') }
    it { expect(ofx.headers[:security]).to eq('NONE') }
    it { expect(ofx.headers[:encoding]).to eq('USASCII') }
    it { expect(ofx.headers[:charset]).to eq('1252') }
    it { expect(ofx.headers[:compression]).to eq('NONE') }
    it { expect(ofx.headers[:oldfileuid]).to eq('NONE') }
    it { expect(ofx.headers[:newfileuid]).to eq('NONE') }

    it { expect(ofx.account[:bankid]).to eq('001') }
    it { expect(ofx.account[:acctid]).to eq('00000-0') }
    it { expect(ofx.account[:branchid]).to eq('000-0') }
    it { expect(ofx.account[:accttype]).to eq('CHECKING') }
    it { expect(ofx.account[:full_account]).to eq('000-0 - 00000-0') }

    it { expect(ofx.transactions.count).to eq(2) }
    it { expect(ofx.transactions.first[:trntype]).to eq('OTHER') }
    it { expect(ofx.transactions.first[:dtposted]).to eq('20171205120000[-3:BRT]') }
    it { expect(ofx.transactions.first[:trnamt]).to eq('6500.00') }
    it { expect(ofx.transactions.first[:fitid]).to eq('000000000000000') }
    it { expect(ofx.transactions.first[:memo]).to match(/Conta/) }
  end

  context 'example 02' do
    let!(:ofx) { OFXReader.(file_fixture('bb02.ofx').read) }
    it { expect(ofx.headers[:ofxheader]).to eq('100') }
    it { expect(ofx.headers[:data]).to eq('OFXSGML') }
    it { expect(ofx.headers[:version]).to eq('102') }
    it { expect(ofx.headers[:security]).to eq('NONE') }
    it { expect(ofx.headers[:encoding]).to eq('USASCII') }
    it { expect(ofx.headers[:charset]).to eq('1252') }
    it { expect(ofx.headers[:compression]).to eq('NONE') }
    it { expect(ofx.headers[:oldfileuid]).to eq('NONE') }
    it { expect(ofx.headers[:newfileuid]).to eq('NONE') }
    #
    it { expect(ofx.account[:bankid]).to eq('001') }
    it { expect(ofx.account[:acctid]).to eq('00000-0') }
    it { expect(ofx.account[:accttype]).to eq('CHECKING') }
    it { expect(ofx.account[:full_account]).to eq('00000-0') }
    #
    it { expect(ofx.transactions.count).to eq(1) }
    it { expect(ofx.transactions.first[:trntype]).to eq('DEP') }
    it { expect(ofx.transactions.first[:dtposted]).to eq('20171005') }
    it { expect(ofx.transactions.first[:trnamt]).to eq('7586.21') }
    it { expect(ofx.transactions.first[:fitid]).to eq('000000000000000') }
    it { expect(ofx.transactions.first[:memo]).to eq('TED-CREDITO EM CONTA') }
  end
end
