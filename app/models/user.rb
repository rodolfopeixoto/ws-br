class User < ApplicationRecord

  before_create :generate_authentication_token!

  has_many :properties, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :auth_token, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def generate_authentication_token!
    begin
        self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

end
