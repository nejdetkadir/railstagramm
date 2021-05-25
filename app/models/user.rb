class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :github]

  validates_presence_of [:fullname, :birthday, :username]
  validates_uniqueness_of :username

  def self.from_omniauth(access_token)
    # You can learn which provider used
    # provider = access_token.provider 

    data = access_token.info

    user = User.where(email: data['email']).first

    unless user
      user = User.create(email: data['email'],password: Devise.friendly_token[0,20])
    end
    user
  end
end
