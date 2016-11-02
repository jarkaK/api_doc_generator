require 'json'

require 'extensions/example_groups'
require 'extensions/string'

require 'api_doc_generator/version'
require 'api_doc_generator/writer/endpoint/base'
require 'api_doc_generator/writer/endpoint/api_blueprint'
require 'api_doc_generator/writer/index/base'
require 'api_doc_generator/writer/index/api_blueprint'
require 'api_doc_generator/helpers'

RSpec.configure do |config|
  include ApiDocGenerator::Helpers
  config.add_setting :api_name, default: 'API'
  config.add_setting :api_description, default: 'API of the app'
  config.add_setting :api_docs_path, default: File.join(File.expand_path('.'), '/api_docs/')

  config.before(:suite) do
    prepare_api_docs
  end

  config.after(:each, type: :request) do
    document_endpoint if ENV['GENERATE_DOCS']
    include_endpoints
  end
end
