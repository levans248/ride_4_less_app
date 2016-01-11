class SessionsController < ApplicationController

def create
  # raise request.env["omniauth.auth"].to_yaml
  auth = request.env["omniauth.auth"]
  user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
  session[:user_id] = user.id
  flash[:success] = "Signed In!"
  redirect_to '/uber_histories'
end

def destroy
  User.find_by(id:session[:user_id]).delete
  session[:user_id] = nil
  flash[:danger] = "Signed Out!"
  redirect_to root_url
end


end
