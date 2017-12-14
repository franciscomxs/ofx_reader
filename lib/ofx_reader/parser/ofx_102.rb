module OFXReader
  module Parser
    class OFX102 < OFXReader::Parser::Base

      ACCOUNT_TYPES = [
        "CHECKING",
        "SAVINGS",
        "CREDITCARD",
        "CREDITLINE",
        "INVESTMENT",
        "MONEYMRKT",
      ]

      TRANSACTION_TYPES = [
        'ATM', 'CASH', 'CHECK', 'CREDIT', 'DEBIT', 'DEP', 'DIRECTDEBIT',
        'DIRECTDEP', 'DIV', 'FEE', 'INT', 'OTHER', 'PAYMENT', 'POS',
        'REPEATPMT', 'SRVCHG', 'XFER',
      ].inject({}) { |hash, type| hash.tap { |h| h[type] = type.downcase } }

      def account
        {
          bank_id: body.search('BANKACCTFROM BANKID').inner_text,
          account_id: body.search('BANKACCTFROM ACCTID').inner_text,
        }
      end

      def transactions
        body.search('BANKTRANLIST STMTTRN').map do |node|
          build_transaction(node)
        end
      end

      private

      def build_transaction(node)
        node.children.map.with_object({}) do |field, hash|
          hash[field.name.downcase.to_sym] = field.text
        end
      end
    end
  end
end
