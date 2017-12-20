require 'spec_helper'

RSpec.describe OFXReader do
  let!(:ofx) { OFXReader.(file_fixture('itau.ofx').read) }
  it { expect(ofx.headers[:ofxheader]).to eq('100') }
  it { expect(ofx.headers[:data]).to eq('OFXSGML') }
  it { expect(ofx.headers[:version]).to eq('102') }
  it { expect(ofx.headers[:security]).to eq('NONE') }
  it { expect(ofx.headers[:encoding]).to eq('USASCII') }
  it { expect(ofx.headers[:charset]).to eq('1252') }
  it { expect(ofx.headers[:compression]).to eq('NONE') }
  it { expect(ofx.headers[:oldfileuid]).to eq('NONE') }
  it { expect(ofx.headers[:newfileuid]).to eq('NONE') }

  it { expect(ofx.account[:bankid]).to eq('1234') }
  it { expect(ofx.account[:acctid]).to eq('1234567890') }
  it { expect(ofx.account[:accttype]).to eq('CHECKING') }
  it { expect(ofx.account[:full_account]).to eq('1234567890') }

  it { expect(ofx.transactions.count).to eq(2) }
  it { expect(ofx.transactions.first[:trntype]).to eq('DEBIT') }
  it { expect(ofx.transactions.first[:dtposted]).to eq('20170814100000[-03:EST]') }
  it { expect(ofx.transactions.first[:trnamt]).to eq('-500000.00') }
  it { expect(ofx.transactions.first[:fitid]).to eq('00000000000') }
  it { expect(ofx.transactions.first[:memo]).to eq('FORNECEDORES') }
end
