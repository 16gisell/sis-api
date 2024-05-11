class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable 
  
 validates :email, presence: true, format: { with: /\A([^@\s]+)@siscotelcloud\.com\z/, message: "El correo electrónico debe ser perteneciente a siscotel" }
  

  def generate_new_authentication_token
    token = Admin.generate_unique_secure_token
    update(authentication_token: token)
  end
end
