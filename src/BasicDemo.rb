require 'sinatra'

##########################
#simple get
##########################
get '/' do
  "hello world get"
end

##########################
#simple post
##########################
#ultra basic post
post '/' do
  "hello world basic post"
end

post '/posthere' do
  p_derp = params[:derp]
  "<b>Received: #{p_derp}</b>"
end

##########################
#define content type
##########################
get '/headertest' do
  headers['Content-Type'] = 'application/xml'
  "<xml><tagname>hi there</tagname></xml>"
end

##########################
#redirect
##########################
get '/redir_remote' do
  redirect "http://google.com"
end

get '/redir_local' do
  redirect "/headertest"
end
  

#########################################################################

puts "Welcome to the demo\n\n\n\n\n"

