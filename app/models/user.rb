class User < ActiveRecord::Base
  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)

    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.email = auth.info.email
    user.location = auth.info.location
    user.image_url = auth.info.picture
    user.token = auth.credentials.token
    user.save

    user
  end


end
