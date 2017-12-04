require 'rspec/expectations'

RSpec::Matchers.define :be_a_list_of do |klass|
  match do |collection|
    collection.map { |object| object.is_a?(klass) }.all?
  end
end
