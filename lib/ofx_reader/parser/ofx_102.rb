module OFXReader
  module Parser
    class OFX102 < Struct.new(:ofx_body, :strict)
      def parse
        raise OFXReader::OFXWithoutBankAccountError if empty_account?
        [account, transactions]
      end

      def account
        build_account(
          build(ofx_body.search('BANKACCTFROM'))
        )
      end

      def build_account(hash)
        full_account = [
          hash.dig(:branchid),
          hash.dig(:acctid)
        ].compact.join(' - ')

        hash[:bankid] = hash[:bankid].
          reverse[0..2].
          reverse.
          rjust(3, '0') if hash[:bankid].present?

        hash.merge!({
          full_account: full_account
        }) if hash.dig(:acctid).present?

        hash
      end

      def transactions
        ofx_body.search('BANKTRANLIST STMTTRN').map do |node|
          build(node)
        end
      end

      private

      def build(node)
        node.children.map.with_object({}) do |field, hash|
          # Avoid Nokogiri::XML::Text
          if field.is_a?(Nokogiri::XML::Element)
            hash[field.name.downcase.to_sym] = field.text
          end
        end
      end

      def empty_account?
        (account.dig(:bankid).blank? && account.dig(:acctid).blank?) && strict
      end
    end
  end
end
