module ApiDocGenerator
  module Writer
    module Endpoint
      # Base class for generating documentation for enpoints
      class Base
        attr_reader :request_data

        def initialize(request_data)
          @request_data = request_data
        end

        private

        def json(data)
          JSON.pretty_generate(JSON.parse(data))
        end

        def resource
          # remove / in the end of path if needed
          @resource ||= endpoint_path[-1] == '/' ? endpoint_path[0..-2] : endpoint_path
        end

        def endpoint_parts
          @endpoint_parts ||= resource.split('/')
        end

        def file_name
          # first part of the enpoint path will be the file name
          @file_name ||= endpoint_parts.reject!(&:empty?)[0].underscore
        end

        def action
          method = request_data.env['REQUEST_METHOD']
          @action ||= "#{endpoint_parts.join('/')} [#{method}]"
        end

        def file
          @file ||= File.new(file_path, 'a')
        end

        def file_path
          @file_path ||= "#{base_dir}#{file_name}.#{self.class::EXTENSION}"
        end
      end
    end
  end
end
