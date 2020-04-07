require 'sinatra'

class PageCrawlerApp < Sinatra::Base
  get '/' do
    "Hello, world!"
  end
end