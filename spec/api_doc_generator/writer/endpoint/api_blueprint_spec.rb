require 'spec_helper'

describe ApiDocGenerator::Writer::Endpoint::ApiBlueprint do
  before do
    expect(File).to receive(:new).with("#{base_dir}events.apib", 'a').and_return(file)
  end

  let(:writer) { described_class.new(request_data) }

  let(:body_hash) do
    { data: 'some' }
  end
  let(:env) do
    {
      'REQUEST_METHOD' => 'GET',
      'PATH_INFO'      => '/events'
    }
  end
  let(:request_data) do
    double(
      body: double(read: body_hash),
      env: env
    )
  end
  let(:content_type) { 'application/json' }

  let(:file) { double }

  describe '#group_header' do
    let(:class_name) { 'RSpec::ExampleGroups::ResourceGroup::EventsCollection::GET /::List' }
    subject { writer.group_header(class_name) }

    before do
      expect(file).to receive(:write).with("# Resource Group\n\n")
      expect(file).to receive(:write).with("# Events Collection [/events]\n\n")
    end

    it { subject }
  end

  describe '#action_header' do
    context 'with params' do
      let(:params) do
        [
          { name: 'api_token', example: 'dhk78ss', type: 'string', required: true },
          { name: 'sort', example: '+title', type: 'string' },
          { name: 'page', type: 'numeric', description: 'page number', required: false },
          { name: 'per_page' }
        ]
      end
      subject { writer.action_header(params) }

      before do
        expect(file).to receive(:write).with("## events [GET]\n\n")
        expect(file).to receive(:write).with("+ Parameters\n")
        expect(file).to receive(:write).with("    + api_token: `dhk78ss` (string, required)\n")
        expect(file).to receive(:write).with("    + sort: `+title` (string, optional)\n")
        expect(file).to receive(:write).with("    + page (numeric, optional) - page number\n")
        expect(file).to receive(:write).with("    + per_page\n")
        expect(file).to receive(:write).with("\n")
      end

      it { subject }
    end

    context 'without params' do
      subject { writer.action_header(nil) }

      before do
        expect(file).to receive(:write).with("## events [GET]\n\n")
      end

      it { subject }
    end

    context 'with params array empty' do
      subject { writer.action_header([]) }

      before do
        expect(file).to receive(:write).with("## events [GET]\n\n")
      end

      it { subject }
    end
  end

  describe '#response' do
    subject { writer.response(response) }
    let(:response) do
      double(
        status: 200,
        content_type: 'json/application',
        body: response_body
      )
    end

    context 'with response body' do
      let(:response_body) { '{ "data": ["some array"] }' }
      let(:expected_json) { JSON.pretty_generate(JSON.parse(response_body)).indent_lines(8) }

      before do
        expect(file).to receive(:write).with("+ Response 200 (json/application)\n\n")
        expect(file).to receive(:write).with("#{expected_json}\n\n")
      end

      it { subject }
    end

    context 'without body' do
      let(:response_body) { nil }

      before do
        expect(file).to receive(:write).with("+ Response 200 (json/application)\n\n")
      end

      it { subject }
    end
  end
end
