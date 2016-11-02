require 'spec_helper'

describe String do
  describe '#underscore' do
    it { expect('SomeString that is nice'.underscore).to eq('some_string that is nice') }
    it { expect('SomeString that is NotSonice'.underscore).to eq('some_string that is not_sonice') }
  end

  describe '#indent_lines' do
    let(:string) do
      "some line\n  nice incention\n"
    end
    let(:indented_string) do
      "  some line\n    nice incention\n"
    end

    it { expect(string.indent_lines(2)).to eq(indented_string) }
  end
end
