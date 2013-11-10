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

post "/query/?" do
  puts params
  query_received_email(params["query"], params["zip"], params["email"])
end

get '/offcourse' do
  @title = "Ye Ship Has Gone Off Course!"
  erb :offcourse, :layout => false
end

not_found do
  redirect '/offcourse'
end

def query_received_email(query, zip, submitter_email)
  # Send received message
  conn = Faraday.new(:url => 'https://api.mailgun.net/v2') do |faraday|
    faraday.request  :url_encoded
    faraday.adapter  Faraday.default_adapter
  end

  conn.basic_auth('api', 'key-8q69y-ssazgujpbohiedzm4s3oyoz911')

  fields = {
    :from => 'Moonsearch Bot <hi@moonshothq.com>',
    :to => "ted@tedlee.me",
    :subject => 'New Moonsearch Request!',
    :html => erb(:query_received, :layout => false , :locals => {:query => query, :zip => zip, :submitter_email => submitter_email})
  }
  puts fields
  conn.post('audobox.com/messages', fields)
end