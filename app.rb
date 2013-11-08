$stdout.sync = true

require "sinatra"
require "faraday"
require 'rack-flash'

require './lib/models.rb' # set up DB
#require './lib/warden.rb' # set up auth
require './lib/helpers.rb'

#include WardenHelpers
helpers Helpers

set :erb, :escape_html => true

#########################
#                       #
#   Web Related Routes  #
#                       #
#########################

get "/" do
  @title = "moonsearch"
  erb :index, :layout => false
end

get '/offcourse' do
  @title = "Ye Ship Has Gone Off Course!"
  erb :offcourse, :layout => false
end

not_found do
  redirect '/offcourse'
end