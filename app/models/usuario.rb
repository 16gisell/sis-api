class Usuario < ApplicationRecord
    belongs_to :tipo_usuarios, foreign_key: :tipo_usuario_id, class_name: 'TipoUsuario'
    belongs_to :tipo_documentos, foreign_key: :tipo_documento_id, class_name: 'TipoDocumento'

    validates :nombre, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "Solo se permite letras para el nombre" }
    validates :razon_social, presence: true
    validates :correo, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/ , message: "Debe incluir un correo valido" } 
    validates :telefono_principal, presence: true, uniqueness: true, format: { with: /\A0\d+\z/ , message: "Numero telefonico debe iniciar en 0"} 
    validates :telefono_secundario, format: { with: /\A0\d+\z/ , message: "Numero telefonico debe iniciar en 0"}
    validates :fecha_emicion_doc, presence: true #format: {with: /\A(\d{1,2})\/(\d{1,2})\/(\d{4})\z/ , message:"El formato de fecha no coincide con DD/MM/AAAA"}
    validates :fecha_vencimiento_doc, presence: true
    validates :numero_documento, presence:true, uniqueness: true
    validate :validate_email
    validate :validate_fecha
    before_save :set_value_fecha

    private

    def validate_email
        correo = self.correo
        unless correo =   /\A([^@]+)@([\w\.-]+)\.([^\s]+)\z/           
            errors.add(:message, "Debe incluir un correo valido")
        end
    end

    def validate_fecha
        fecha_emi = self.fecha_emicion_doc.strftime("%d/%m/%Y")
        fehca_ven = self.fecha_vencimiento_doc.strftime("%d/%m/%Y")

        if self.fecha_vencimiento_doc.strftime("%Y").to_i < self.fecha_emicion_doc.strftime("%Y").to_i
            errors.add(:message, "Error en fechas la fecha de vencimiento es menor a la fecha de emision")
        end
    end

    def set_value_fecha
        self.fecha_emicion_doc = self.fecha_emicion_doc.strftime("%d/%m/%Y")
        self.fecha_vencimiento_doc = self.fecha_vencimiento_doc.strftime("%d/%m/%Y")
    end
    
end
