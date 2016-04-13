require 'sinatra'

helpers do  
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['jason', 'jason']
  end
end

count = 0

get '/add' do
  protected!
  count += 1
  "Added count at #{Time.now}"
end

get '/show' do
  "<b>Count is:</b> #{count}"
end