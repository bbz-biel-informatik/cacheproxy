require 'sinatra'
require 'faraday'
require 'redis'

redis = Redis.new(url: ENV['REDIS_URL'] || "redis://localhost:6379/1")

get '/get/*' do
  path = request.fullpath.gsub(/^\/get\//, '')
  url = "https://#{path}"

  body = redis.get(url)

  if body
    puts "HIT"
    response.headers['X-Cache-Status'] = 'HIT'
    content_type 'application/json'
    status 200
    return body
  end

  puts "MISS"
  response = Faraday.get(url)
  if response.status == 200
    puts "SET"
    redis.set(url, response.body)
  end

  response.headers['X-Cache-Status'] = 'MISS'
  content_type 'application/json'
  status response.status
  return response.body
end

get '/del/*' do
  path = request.fullpath.gsub(/^\/del\//, '')
  url = "https://#{path}"

  redis.del(url)
  return "DELETED #{url}"
end
