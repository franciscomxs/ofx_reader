module OFXReader
  module Parser
    class Base
      require 'nokogiri'
      require 'time'

      attr_reader :headers, :body, :content

      def initialize(content)
        @content = content.encode("UTF-8", "ISO-8859-1")
        @headers, @body = read(@content)
      end

      private

      def read(content)
        headers, body = content.dup.split(/(?=<OFX>)/, 2)
        headers = parse_headers(headers)
        body = parse_body(body)
        [headers, body]
      end

      def parse_headers(headers)
        headers.each_line.with_object({}) do |line, hash|
          _, k, v = *line.match(/^(.*?):(.*?)\s*(\r?\n)*$/)
          hash[k] = v unless v.nil?
        end
      end

      def parse_body(body)
        # body.prepend('<OFX>')
        body.gsub!(/>\s+</m, '><')
        body.gsub!(/\s+</m, '<')
        body.gsub!(/>\s+/m, '>')
        body.gsub!(/<(\w+?)>([^<]+)/m, '<\1>\2</\1>')
        body = ::Nokogiri::XML(body)
      end
    end
  end
end
