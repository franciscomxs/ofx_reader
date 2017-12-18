module OFXReader
  module Parser
    class OFX102 < Struct.new(:ofx_body)
      def parse
        [account, transactions]
      end

      def account
        {
          bank_id: ofx_body.search('BANKACCTFROM BANKID').inner_text,
          account_id: ofx_body.search('BANKACCTFROM ACCTID').inner_text,
        }
      end

      def transactions
        ofx_body.search('BANKTRANLIST STMTTRN').map do |node|
          build_transaction(node)
        end
      end

      private

      def build_transaction(node)
        node.children.map.with_object({}) do |field, hash|
          # Avoid Nokogiri::XML::Text
          if field.is_a?(Nokogiri::XML::Element)
            hash[field.name.downcase.to_sym] = field.text
          end
        end
      end
    end
  end
end
