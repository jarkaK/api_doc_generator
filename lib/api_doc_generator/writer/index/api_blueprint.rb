module ApiDocGenerator
  module Writer
    module Index
      # Generating documentation for the index file for APIBlueprint
      class ApiBlueprint < Base
        EXTENSION = 'apib'

        def header(api_name, api_description)
          file.write "# #{api_name}\n\n"
          file.write "#{api_description}\n\n"
        end

        def include_file(file_name)
          file.write "<!-- include(#{file_name}) -->\n"
        end

      end
    end
  end
end
