module OFXReader
  module Parser
    class Base
      require 'nokogiri'
      require 'time'

      attr_reader :header, :body
      attr_reader :headers, :account, :transactions

      def initialize(content)
        content = content.encode("UTF-8", "ISO-8859-1")
        @header, @body = content.dup.split(/(?=<OFX>)/, 2)
        @headers = parse_headers(header)
        @account, @transactions = parse_body(body)
      end

      private

      def parse_headers(headers)
        headers.each_line.with_object({}) do |line, hash|
          _, k, v = *line.match(/^(.*?):(.*?)\s*(\r?\n)*$/)
          hash[k.downcase.to_sym] = v unless v.nil?
        end
      end

      def parse_body(body)
        body.gsub!(/>\s+</m, '><')
        body.gsub!(/\s+</m, '<')
        body.gsub!(/>\s+/m, '>')
        body.gsub!(/<(\w+?)>([^<]+)/m, '<\1>\2</\1>')
        parser.new(::Nokogiri::XML(body)).parse
      end

      def parser
        # TODO: Provide support to other formats
        case headers[:version]
        when /10(2|3)/
          OFXReader::Parser::OFX102
        else
          raise UnsupportedOFXVersionError
        end
      end
    end
  end
end
