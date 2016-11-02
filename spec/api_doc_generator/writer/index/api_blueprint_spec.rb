require 'spec_helper'

describe ApiDocGenerator::Writer::Index::ApiBlueprint do
  before do
    expect(File).to receive(:new).with("#{base_dir}index.apib", 'a').and_return(file)
  end

  let(:writer)   { described_class.new(base_dir) }
  let(:base_dir) { '/something/dir' }
  let(:file)     { double }

  describe '#header' do
    let(:name)        { 'some name' }
    let(:description) { 'some description' }

    subject { writer.header(name, description) }

    before do
      expect(file).to receive(:write).with("# #{name}\n\n")
      expect(file).to receive(:write).with("#{description}\n\n")
    end

    it { subject }
  end

  describe '#include_file' do
    let(:file_name) { 'some_file' }

    subject { writer.include_file(file_name) }

    before do
      expect(file).to receive(:write).with("<!-- include(#{file_name}) -->\n")
    end

    it { subject }
  end
end
