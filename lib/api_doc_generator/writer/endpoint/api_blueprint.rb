module ApiDocGenerator
  module Writer
    module Endpoint
      # Generating documentation for enpoints for APIBlueprint
      class ApiBlueprint < Base
        EXTENSION = 'apib'

        # TODO: do it better than from class_name?
        def group_header(class_name)
          name_parts = class_name.split('::')
          group      = name_parts[2]
          collection = name_parts[3]

          # split group and collection to words
          pattern = /(?=[A-Z])/

          group      = group.split(pattern).join(' ')
          collection = collection.split(pattern).join(' ')

          # write group and collection to file
          file.write "# #{group}\n\n"
          file.write "# #{collection} [/#{file_name}]\n\n"
        end

        def action_header(params)
          file.write "## #{action}\n\n"

          return if !params || params.empty?

          file.write "+ Parameters\n"
          params.each do |param|
            write_param(param)
          end

          file.write "\n"
        end

        # TODO: process request
        def request

        end

        def response(response)
          file.write "+ Response #{response.status} (#{response.content_type})\n\n"

          return if !response.body || response.body.empty?

          file.write "#{json(response.body).indent_lines(8)}\n\n"
        end

        def new_collection?
          !File.file?(file_path)
        end

        private

        def endpoint_path
          return @endpoint_path if @endpoint_path

          path = request_data.env['PATH_INFO']

          pattern = %r{(/\d+/)|(/\d+$)/}
          matches = path.match(pattern)
          if matches
            matches.to_a[1..-1].each do |match|
              path.sub!(match.to_s, '/{id}/') if match
            end
          end

          path
        end

        def write_param(param)
          line = "    + #{param[:name]}"
          line += ": `#{param[:example]}`" if param[:example]
          if param[:type]
            required = param[:required] ? 'required' : 'optional'
            line += " (#{param[:type]}, #{required})"
          end

          line += " - #{param[:description]}" if param[:description]
          line += "\n"
          file.write line
        end
      end
    end
  end
end
