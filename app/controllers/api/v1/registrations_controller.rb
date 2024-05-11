class Api::V1::RegistrationsController < Devise::RegistrationsController
  include ValidateApikeyHelper
  before_action :authenticate_api_key!
  before_action :ensure_params_exist, only: :create
  
  #registramos administrador
  def create
    if @key_validate = true
      begin
        admin = Admin.new(admin_params)
        if admin.save
          build_success_create "Usuario registrado correctamente"
        else
          respuesta =  admin.errors.full_messages
          build_error respuesta
        end
      rescue
        build_error "Error de consulta crear admin compruebe la solicitud"    
      end
    end
  end
  
  #metodo para resetear password
  def create_password_reset_token
    if @key_validate = true
      begin
        admin = Admin.find_by_email(params[:email])
        if admin
          admin.send_reset_password_instructions
          build_success "Nuevo password enviado al correo", { result: admin }
        else
          respuesta =  admin.errors.full_messages
          build_error respuesta
        end
      rescue
        build_error "Error de consulta rest-token compruebe la solicitud"    
      end
    end
  end
  
  #actualizamos password
  def update_password
    admin = Admin.with_reset_password_token(params[:reset_password_token])
    begin
      if admin
        if admin.update(password: params[:password], password_confirmation: params[:password_confirmation])
          build_success_content "Password actualizada correctamente"
        else
          respuesta =  admin.errors.full_messages
          build_error respuesta
        end
      else
        build_error_permisso "Token invalido"
      end
    rescue
      build_error "Error de consulta update_password compruebe la solicitud"    
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
      build_error_permisso "Parametros requeridos"
    end
end
