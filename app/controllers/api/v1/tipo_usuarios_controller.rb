class Api::V1::TipoUsuariosController < ApplicationController
  include ValidateApikeyHelper
  include PaginacionHelper
  before_action :authenticate_api_key!
  before_action :valid_token
  before_action :set_api_v1_tipo_usuario, only: %i[ show update ]


  def index
    objet_pagination(params[:page], params[:per_page], params[:filter], TipoUsuario)
  end


  def show
    json_response "Tipo personas", true, { result:  @api_v1_tipo_usuario, pagination: [] }, 200 
  end


  def create
    @api_v1_tipo_usuario = TipoUsuario.new(api_v1_tipo_usuario_params)
    if @api_v1_tipo_usuario.save
      json_response "Tipo personas guardado con exito", true, { result:  @api_v1_tipo_usuario, pagination: [] }, 200 
    else
      respuesta =  @api_v1_usuario.errors.full_messages
      json_response respuesta, false, {}, 422
    end
  end

  def update
    if @api_v1_tipo_usuario.update(api_v1_tipo_usuario_params)
      json_response "Tipo personas Actualizado con exito", true, { result:  @api_v1_tipo_usuario, pagination: [] }, 200 
    else
      respuesta =  @api_v1_usuario.errors.full_messages
      json_response respuesta, false, {}, 422
    end
  end

  def destroy
    @api_v1_tipo_usuario.destroy!
  end

  private
    def set_api_v1_tipo_usuario
      @api_v1_tipo_usuario = TipoUsuario.find(params[:id])
    end

    def api_v1_tipo_usuario_params
      params.require(:tipo).permit(:nombre, :clave)
    end

    def authenticate_api_key!
      @key_validate = validate_authenticate_api_key
    end

    def valid_token
      @token_validate = validate_authenticate_token
    end
end
