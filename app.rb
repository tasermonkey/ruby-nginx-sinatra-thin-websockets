require 'sinatra/base'
require 'eventmachine'

require "sinatra/json"
require 'awesome_print'
require 'json'
require 'require_all'

class MyApp < Sinatra::Application
  attr_reader :request_payload
  set :server,'thin'
  set :show_exceptions, true
  set :dump_errors, true
  set :root, File.dirname(__FILE__)

  before do
    if self.request.media_type == "application/json" && request.content_length.to_i > 0
      request.body.rewind
      @request_payload = ActiveSupport::JSON.decode(request.body.read).deep_symbolize_keys!
    end
  end

    get '/try' do
      json "helloworld"
    end
end
require_rel 'app/controllers'
MyApp.run! if $0 == "app.rb"
