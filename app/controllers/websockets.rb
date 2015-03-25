require 'sinatra-websocket'
class MyApp < Sinatra::Application
  WEBSOCKETS_BASE = '/websockets'
  set :sockets, []
  get "#{WEBSOCKETS_BASE}/?" do
    if !request.websocket?
      halt 500, json({message: "This end point must be for ws:// "})
    else
      request.websocket do |ws|
        ws.onopen do
          settings.sockets << ws
          puts "Connected to #{request.path}. #{params[:client_name]}"
          ws.send "Connected to #{params[:client_name]}."
        end
        ws.onmessage do |msg|
          puts "Received Message: #{msg}"
          settings.sockets.each do |socket|
            puts "Sending #{msg}"
            socket.send "Server replies: #{msg}"
          end
        end
        ws.onclose do
          warn("websocket closed")
          settings.sockets.delete(ws)
          puts "Client closed"
          ws.send "Closed."
          settings.sockets.delete ws
        end
      end
    end
  end


end
