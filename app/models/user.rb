class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    @id = 1
    create! do |user|
      user.id = @id + 1
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["first_name"]
      user.token = auth["credentials"]["token"]
      user.refresh_token = auth["credentials"]["refresh_token"]
    end  
  end 
end
