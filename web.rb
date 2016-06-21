require 'sinatra'
require "sinatra/cookies"

get '/' do
  "Hello, world"
end

post "/sso/login" do
  pre_token = params[:id] + ':' + "zPzckKkGf3XiJaD0" + ':' + params[:timestamp]
  # pre_token = params[:id] + ':' + HEROKU_SSO_SALT + ':' + params[:timestamp]
  token = Digest::SHA1.hexdigest(pre_token).to_s
  halt 403 if token != params[:token]
  halt 403 if params[:timestamp].to_i < (Time.now - 2*60).to_i

  # account = Account.find(params[:id])
  # halt 404 unless account

  # session[:user] = account.id
  # session[:heroku_sso] = true
  cookies['heroku-nav-data'] = 'eyJhZGRvbiI6IllvdXIgQWRkb24iLCJhcHBuYW1lIjoibXlhcHAiLCJhZGRvbnMiOlt7InNsdWciOiJjcm9uIiwibmFtZSI6IkNyb24ifSx7InNsdWciOiJjdXN0b21fZG9tYWlucyt3aWxkY2FyZCIsIm5hbWUiOiJDdXN0b20gRG9tYWlucyArIFdpbGRjYXJkIn0seyJzbHVnIjoieW91cmFkZG9uIiwibmFtZSI6IllvdXIgQWRkb24iLCJjdXJyZW50Ijp0cnVlfV19'
  redirect "http://localhost:8080"
end
