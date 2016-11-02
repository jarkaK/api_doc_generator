module ApiDocGenerator
  module Helpers
    def prepare_api_docs
      return unless ENV['GENERATE_DOCS']

      Dir.mkdir(base_dir) unless Dir.exist?(base_dir)
      Dir.glob(File.join(base_dir, '*')).each { |f| File.delete(f) }

      # TODO: try to solve this differently
      $index_processor = ApiDocGenerator::Writer::Index::ApiBlueprint.new(base_dir)
      $index_processor.header(config.api_name, config.api_description)
    end

    def document_endpoint
      return unless last_response

      writer = processor_class.new(last_request)

      # TODO: is it possible to do it better than using self.class.name?
      writer.group_header(self.class.name) if writer.new_collection?
      writer.action_header(self.class.params)
      writer.request
      writer.response(last_response)
    end

    def include_endpoints
      Dir.glob(File.join(base_dir, '*')).each do |file|
        next if file == $index_processor.file.path
        $index_processor.include_file(file.split('/').last)
      end
    end

    def base_dir
      RSpec.configuration.api_docs_path
    end

    def config
      RSpec.configuration
    end

    # TODO: make processor class configurable
    def processor_class
      ApiDocGenerator::Writer::Endpoint::ApiBlueprint
    end
  end
end
