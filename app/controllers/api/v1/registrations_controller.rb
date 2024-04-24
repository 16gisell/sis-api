class Api::V1::RegistrationsController < Devise::RegistrationsController
  include ValidateApikeyHelper
  before_action :authenticate_api_key!
  before_action :ensure_params_exist, only: :create
  
  #registramos administrador
  def create
    if @key_validate = true
      admin = Admin.new(admin_params)
      if admin.save
        json_response "Usuario registrado correctamente", true, { admin: admin }, 200
      else
        respuesta =  admin.errors.full_messages
        json_response respuesta, false, {}, 422
      end
    end
  end
  
  #metodo para resetear password
  def create_password_reset_token
    if @key_validate = true
      admin = Admin.find_by_email(params[:email])
      if admin
        admin.send_reset_password_instructions
        json_response "Nuevo password enviado al correo", true, { admin: admin }, 200
      else
        respuesta =  admin.errors.full_messages
        json_response respuesta, false, {}, 422
      end
    end
  end
  
  #actualizamos password
  def update_password
    admin = Admin.with_reset_password_token(params[:reset_password_token])
    if admin
      if admin.update(password: params[:password], password_confirmation: params[:password_confirmation])
        json_response "Password actualizada correctamente", true, { admin: admin }, 200
      else
        respuesta =  admin.errors.full_messages
        json_response respuesta, false, {}, 422
      end
    else
        json_response "Token invalido", false, {}, 404
    end
  end
  
    private
  
    #validamos si el metodo posee el header de autorizacion parametro requerido
    def authenticate_api_key! 
      @key_validate = validate_authenticate_api_key
    end
  
    def admin_params
      params.require(:admin).permit(:email, :password, :password_confirmation)
    end
  
    def ensure_params_exist
      return if params[:admin].present?
      json_response "Parametros requeridos", false, {}, 404
    end
end
