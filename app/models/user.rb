class User < ActiveRecord::Base
  has_many :invitaions
  
  before_save { self.email = email.downcase }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  has_secure_password

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.email = auth.info.email
    user.location = auth.info.location
    user.image_url = auth.info.picture
    user.token = auth.credentials.token
    user.password = SecureRandom.urlsafe_base64
    user.save

    user
  end


end
