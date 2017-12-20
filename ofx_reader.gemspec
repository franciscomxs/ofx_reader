lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ofx_reader/version"

Gem::Specification.new do |spec|
  spec.name          = "ofx_reader"
  spec.version       = OFXReader::VERSION
  spec.authors       = ["Francisco Martins"]
  spec.email         = ["franciscomxs@gmail.com"]

  spec.summary       = "A simple ofx reader"
  spec.homepage      = "https://github.com/franciscomxs/ofx_reader"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.8"
  spec.add_dependency "activesupport", "> 4"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11"
end
