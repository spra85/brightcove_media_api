require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'brightcove-api'
require 'webmock'
require 'webmock/rspec'

require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'brightcove_config')
require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'request')
require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'video')
require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'playlist')

BrightcoveConfig.configuration_files = File.expand_path(File.join(File.dirname(__FILE__), 'test_account.yml'))
