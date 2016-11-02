module ApiDocGenerator
  module Writer
    module Index
      # Base class for generating documentation for the index file
      class Base
        attr_reader :file

        def initialize(base_dir)
          @file = File.new("#{base_dir}index.#{self.class::EXTENSION}", 'a')
        end
      end
    end
  end
end
