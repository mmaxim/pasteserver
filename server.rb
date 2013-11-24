require 'sinatra'
require 'sinatra/base'
require 'json'

class PasteServer < Sinatra::Base

    @@history = Array.new

    post '/paste' do
        newpaste = request.body.read
        @@history.unshift(newpaste)
        if @@history.length == 10
            @@history.pop
        end

        JSON.generate({:result => true})
    end

    get '/paste' do
        res = ""
        if @@history.length > 0
            res = @@history[0]
        end

        JSON.generate({:result => res})
    end

    get '/history' do
        JSON.generate({:result => @@history}) 
    end

    run! if app_file == $0

end
