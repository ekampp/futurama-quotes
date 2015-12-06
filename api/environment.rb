require 'bundler'
Bundler.require :default

$env = String(ENV['RACK_ENV'].presence || 'development')
Bundler.require :default, $env

$root = Pathname.pwd
$:.unshift $root.to_s
$:.unshift $root.join('models').to_s

$db_config = YAML.load(File.open("#{$root}/db/config.yml"))[$env]
ActiveRecord::Base.establish_connection($db_config)

Dir[$root.join('models', '*.rb')].each { |f| require f }

class Array
  def symbolize_keys
    map(&:symbolize_keys)
  end
end

require_relative './api'
