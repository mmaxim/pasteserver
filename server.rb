require 'sinatra'
require 'sinatra/base'

class PasteServer < Sinatra::Base

    @@curpaste = ""

    post '/setpaste' do
        @@curpaste = request.body.read
    end

    get '/getpaste' do
        @@curpaste
    end

    run! if app_file == $0
end
