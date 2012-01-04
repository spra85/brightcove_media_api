require 'config_object'
require 'brightcove-api'

class BrightcoveConfig
  include ConfigObject

  attr_reader :account_id, :read_tokens, :url_read_tokens, :write_tokens
  attr_accessor :read_apis, :url_read_apis, :write_apis

  class << self
    def current
      unless @current
        @current = self.find("brightcove_account")
        bootstrap_api_classes
      end

      return @current
    end

    private

      def bootstrap_api_classes
        initialize_api_classes("read") if @current.read_tokens
        initialize_api_classes("url_read") if @current.url_read_tokens
        initialize_api_classes("write") if @current.write_tokens
      end

      def initialize_api_classes(type)
        @current.send("#{type}_apis=", [])

        @current.send("#{type}_tokens").each{ |token| @current.send("#{type}_apis") << Brightcove::API.new(token) }
      end
  end
end
