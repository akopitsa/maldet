require 'spec_helper'
describe 'maldet' do
  context 'with default values for all parameters' do
    it { should contain_class('maldet') }
  end
end
