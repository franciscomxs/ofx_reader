require "ofx_reader/version"

begin
  require "pry"
rescue LoadError
end

require "ofx_reader/parser/base"
require "ofx_reader/parser/ofx_102"

module OFXReader
  # Your code goes here...
end
