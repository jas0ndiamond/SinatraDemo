require 'sinatra'

set :bind, '0.0.0.0'

get '/cam' do
  headers['Content-Type'] = 'image/jpeg'
    
  env_opts = ENV["CAM_ARGS"]
    
  puts "Found local cam args #{env_opts}"
    
  return `/usr/bin/raspistill #{env_opts} -w 640 -h 480 -o - --nopreview --timeout 1`
end