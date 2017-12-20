require "ofx_reader/version"
require "active_support/core_ext/object"

begin
  require "pry"
rescue LoadError
end

require "ofx_reader/errors/unsupported_ofx_version_error"
require "ofx_reader/errors/ofx_without_bank_account_error"
require "ofx_reader/parser/base"
require "ofx_reader/parser/ofx_102"

module OFXReader
# ACCOUNT_TYPES = [
#   "CHECKING",
#   "SAVINGS",
#   "CREDITCARD",
#   "CREDITLINE",
#   "INVESTMENT",
#   "MONEYMRKT",
# ]
#
# TRANSACTION_TYPES = [
#   'ATM', 'CASH', 'CHECK', 'CREDIT', 'DEBIT', 'DEP', 'DIRECTDEBIT',
#   'DIRECTDEP', 'DIV', 'FEE', 'INT', 'OTHER', 'PAYMENT', 'POS',
#   'REPEATPMT', 'SRVCHG', 'XFER',
# ]

  def self.call(ofx_text, strict: false)
    OFXReader::Parser::Base.new(ofx_text, strict: strict)
  end
end
