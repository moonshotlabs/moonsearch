require 'rubygems'
require 'bundler/setup'
Bundler.setup(:default)

require File.dirname(__FILE__) + "/lib/models.rb"
require File.dirname(__FILE__) + "/app.rb"

configure :production do
  require 'newrelic_rpm'

  #use Rack::SSL
  #use Rack::Deflater
end

configure :development do

end


run Sinatra::Application
