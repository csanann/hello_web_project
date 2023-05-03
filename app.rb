#file: app.rb


require 'sinatra/base'
require 'sinatra/reloader'


class Application < Sinatra::Base
 # This allows the app code to refresh
 # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end
  #route home
  get '/' do
    return "welcome to the home page!"
  end
  #route: greeting with name  
  get '/greet/:name' do
    "Hello, { params[:name] }!"
    name = params[:name]
  end

  #route for sorting names
  post "/sort-names" do
    if params[:names].nil? || params[:names].empty?
      status 400
      "Error: names parameter is missing or empty."
    else
      names = params[:names].split(",").sort
      names.join(",")
    end
  end
end