require 'active_support/all'

module Brightcove
  module MediaAPI
    class Request

      class << self
        cattr_accessor :logger

        def send_api_post_file(method, file_path, params)
          logger.debug("[POST_FILE] - #{method} - file_path => #{file_path}, params => #{params.inspect}") if logger

          response = write_api.post_file(method, file_path, params)

          handle_response("[POST_FILE]", response)
        end

        def send_api_post(method, params)
          logger.debug("[POST] - #{method} - params => #{params.inspect}") if logger

          response = write_api.post(method, params)

          handle_response("[POST]", response)
        end

        def send_api_get(method, params, url_access = false)
          logger.debug("[GET] - #{method} - params => #{params.inspect}") if logger

          response = url_access ? url_read_api.get(method, params) : read_api.get(method, params)

          handle_response("[GET]", response)
        end

        private

          def handle_response(api_type, response)
            logger.info("#{api_type} response - [#{response.inspect}]") if logger

            logger.error("#{api_type} API error => #{response["error"].inspect}") if response["error"] && logger

            response
          end

          def write_api
            BrightcoveConfig.current.write_apis.rotate!
            BrightcoveConfig.current.write_apis.first
          end

          def read_api
            BrightcoveConfig.current.read_apis.rotate!
            BrightcoveConfig.current.read_apis.first
          end

          def url_read_api
            BrightcoveConfig.current.url_read_apis.rotate!
            BrightcoveConfig.current.url_read_apis.first
          end
      end
    end
  end
end
