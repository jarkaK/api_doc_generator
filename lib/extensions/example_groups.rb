module RSpec
  module Core
    # RSpec ExampleGroup class extensions
    class ExampleGroup
      def self.param(param, options = {})
        @params = [] unless @params

        @params << {
          name:        param,
          type:        options[:type],
          description: options[:description],
          required:    options[:required],
          example:     options[:example]
        }
      end

      def self.params
        @params
      end
    end
  end
end
