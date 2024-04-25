class TipoDocumento < ApplicationRecord
    has_many :usuarios, class_name: 'Usuario' 
    validates :clave, presence: true, uniqueness: true 
    validates :nombre, presence: true
end
