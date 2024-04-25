class TipoUsuario < ApplicationRecord
    has_many :usuarios, class_name: 'Usuario' #, dependent: :restrict_foreign_key
    validates :clave, presence: true, uniqueness: true 
    validates :nombre, presence: true
end
