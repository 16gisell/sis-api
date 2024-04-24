#modelo para seguridad de enpoints se solicitara la autorizacion para poder ejecutar el metodo( el cual se debera pasar desde el header)

class Api::Apikey < ApplicationRecord
  validates :name, presence: true
  #email unico solo se permite un usuario por api-key(con un usuario basta) podemos utilizar esto por si se desea 
  #utilizar el mismo enpoint pero en diferentes aplicaciones
  validates :email, presence: true, uniqueness: true 
  validates :expires_at, presence: true
  validate :validate_email
  
  before_save :set_value_api
  before_validation :set_default_expires_at

  private

  # incluimos de forma aleatoria el valor de api_key
  def set_value_api
    self.api_key_value = SecureRandom.hex(32)
  end

  # tiempo de duracion de la api_key (de momento un minuto)
  def set_default_expires_at
    self.expires_at ||= 1.minute.from_now
  end

  def validate_email
    email = self.email

    unless email =~ /\A([^@\s]+)@siscotelcloud\.com\z/
      errors.add(:menssage, "El correo electrónico debe ser perteneciente a siscotel")
    end
  end
end
