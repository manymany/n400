require 'rubygems'
require 'sinatra'

set :bind, '0.0.0.0'

@@allowed_ips = {"127.0.0.1"=>"127.0.0.1","192.168.10.58" => "192.168.10.58",
                 "192.168.10.161" => "192.168.10.161",
                 "192.168.10.150" => "192.168.10.150",
                 "192.168.10.192"=>"192.168.10.192",
                 "192.168.10.189"=>"192.168.10.189",
                 "192.168.10.184"=>"192.168.10.184"}


configure do
end

helpers do
end

before '/secure/*' do
  begin
  rescue Exception =>e
    puts e.message
    #@error = 'Sorry guacamole, there is no <b>database </b>present to render ' + request.path
    @alert ={ 'type' => 'danger',
              'message' => "Sorry something went wrong. We made note of this."
            }    
    halt erb(:'/public/home')
  end
  if !session[:identity] then
    session[:previous_url] = request.path
    #@error = 'Sorry guacamole, you need to be logged in to visit ' + request.path
    @alert ={ 'type' => 'warning',
              'message' => "Sorry you must be logged in."
            }    
    #halt erb(:'/public/home')
    halt erb(:'/public/getstarted')
  end
end

get '/' do
  erb :'/public/rand', :layout=>:n400
end


get "/n400" do
    erb :'/public/rand', :layout=>:n400
end

