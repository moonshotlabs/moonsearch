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
  # generate_freebie(params["sender"], params["invitee"])
end

get '/offcourse' do
  @title = "Ye Ship Has Gone Off Course!"
  erb :offcourse, :layout => false
end

get '/*/freebie' do
  token = params[:splat][0]
  if Freebie.exists?(token)
    Freebie.consume!(token)
    return "That was a freebie!"
  else
    return "Invalid freebie token"
  end
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

## freebie logic

def generate_freebie(from, to)
  recv_link = "http://www.moonshothq.com/#{Freebie.generate!}/freebie"
  send_link = "http://www.moonshothq.com/#{Freebie.generate!}/freebie"

  conn = Faraday.new(:url => 'https://api.mailgun.net/v2') do |faraday|
    faraday.request  :url_encoded
    faraday.adapter  Faraday.default_adapter
  end

  conn.basic_auth('api', 'key-8q69y-ssazgujpbohiedzm4s3oyoz911')

  recv_fields = {
    :from => "Moonsearch Bot <hi@moonshothq.com>",
    :to => to,
    :subject => 'Try a free Moonsearch!',
    :html => erb(:freebie_recv, :layout => false , :locals => {:from => from, :link => recv_link})
  }

  send_fields = {
    :from => "Moonsearch Bot <hi@moonshothq.com>",
    :to => from,
    :subject => "Thanks for inviting a friend!",
    :html => erb(:freebie_send, :layout => false, :locals => {:link => send_link})
  }

  conn.post('audobox.com/messages', recv_fields)
  conn.post('audobox.com/messages', send_fields)
end

