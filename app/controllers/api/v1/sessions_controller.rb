class Api::V1::SessionsController < Devise::SessionsController
  include ValidateApikeyHelper
  before_action :authenticate_api_key!
  before_action :sign_in_params, only: :create
  before_action :load_admin, only: :create
  before_action :valid_token, only: :destroy
  skip_before_action :verify_signed_out_user, only: :destroy

  #inicio de sesion
  def create
    begin
      if @admin.valid_password?(sign_in_params[:password])
        sign_in "admin", @admin
        build_success "Sesion iniciada con exito", {result: @admin}
      else
        build_error_invalido "No autorizado verifique los datos"
      end
    rescue
      build_error "Error de consulta acceso login compruebe la solicitud"    
    end
  end

  def destroy
    sign_out @admin
    @admin.generate_new_authentication_token
    build_success_content "Cierre de sesion correcta"
  end

  private
    
  def authenticate_api_key!
    @key_validate = validate_authenticate_api_key
  end

  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
  end

  def load_admin
    @admin = Admin.find_for_database_authentication(email: sign_in_params[:email])
    if @admin
      return @admin
    else
      build_error "Ususario no encontrado"
    end
  end

  def valid_token
    @token_validate = validate_authenticate_token
  end
end
