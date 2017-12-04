require 'spec_helper'

RSpec.describe OFXReader::Parser::Base do
  let(:parser) { OFXReader::Parser::Base.new(file_fixture('sample.ofx').read) }
  it { expect(parser.headers).to be_a(Hash) }
  it { expect(parser.body).to be_a(Nokogiri::XML::Document) }
end
