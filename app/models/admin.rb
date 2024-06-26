class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable 
  validate :validate_email
 

  def generate_new_authentication_token
    token = Admin.generate_unique_secure_token
    update(authentication_token: token)
  end

  private

  def validate_email
    email = self.email
    unless email =~ /\A([^@\s]+)@siscotelcloud\.com\z/
      errors.add(menssage: "El correo electrónico debe ser perteneciente a siscotel")
    end
  end
end
