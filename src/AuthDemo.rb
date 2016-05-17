require 'sinatra'

helpers do  
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Totally Not authorized\n"
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['jason', 'jason']
  end
end

######################
count = 0

######################

get '/inc' do
  protected!
  Mutex.new.synchronize do
    count += 1
  end
  "Added one at #{Time.now}"
end

get '/show' do
  Mutex.new.synchronize do
    "<b>Count is:</b> #{count} at #{Time.now}"
  end
end

get '/add' do
  protected!
  val = params[:val]
    
  result = "invalid parameter"
    
  if val != nil and val =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
    Mutex.new.synchronize do
      count += val.to_i
      result = "Added #{val} at #{Time.now}"
    end
  end
  
  return result
end

######################

puts "Launched AuthDemo with count #{count}"