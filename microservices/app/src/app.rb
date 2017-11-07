require 'sinatra'
require 'net/http'
require 'uri'
require 'json'

configure :development do
  set :bind, '0.0.0.0'
  set :port, 8080
  set :DATA_URL, 'http://127.0.0.1:6432/v1/query'
end

configure :production do
  set :DATA_URL, 'http://data.hasura/v1/query'
end

get '/' do
  "Hello Sinatra"
end

get '/get_articles' do
  query = {
      'type' => 'select',
      'args' => {
          'table' => 'article',
          'columns' => [
              '*'
          ]
      }
  }
  uri = URI(settings.DATA_URL)
  req = Net::HTTP::Post.new(uri)
  req.body = query.to_json
  req['Content-Type'] = 'application/json'
  req['X-Hasura-Role'] = 'anonymous'
  req['X-Hasura-User-Id'] = 0
  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
  end
  content_type :json
  res.body.to_json
end
