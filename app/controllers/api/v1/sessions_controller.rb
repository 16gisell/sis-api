class Api::V1::SessionsController < Devise::SessionsController
  include ValidateApikeyHelper
  before_action :authenticate_api_key!
  before_action :sign_in_params, only: :create
  before_action :load_admin, only: :create
  before_action :valid_token, only: :destroy
  skip_before_action :verify_signed_out_user, only: :destroy

  #inicio de sesion
  def create
    if @admin.valid_password?(sign_in_params[:password])
      sign_in "admin", @admin
      json_response "Sesion iniciada con exito", true, {admin: @admin}, 200
    else
      json_response "No autorizado", false, {}, 401
    end
  end

  def destroy
    sign_out @admin
    @admin.generate_new_authentication_token
    json_response "Cierre de sesion correcta", true, {}, 200
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
      json_response "Ususario no encontrado", false, {}, 422
    end
  end

  def valid_token
    @admin = Admin.find_by authentication_token: request.headers["AUTH-TOKEN"]
    if @admin
      return @admin
    else
      json_response "Token de sesion invalido", false, {}, 422
    end
  end
end
