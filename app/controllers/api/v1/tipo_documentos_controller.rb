class Api::V1::TipoDocumentosController < ApplicationController
  include ValidateApikeyHelper
  include PaginacionHelper
  before_action :authenticate_api_key!
  before_action :valid_token
  before_action :set_api_v1_tipo_documento, only: %i[ show update destroy ]

  def index
    objet_pagination(params[:page], params[:per_page], params[:filter], TipoDocumento)
  end

  def show
    json_response "Tipo documento", true, { result:  @api_v1_tipo_documento, pagination: [] }, 200 
  end

  def create
    @api_v1_tipo_documento = TipoDocumento.new(api_v1_tipo_documento_params)

    if @api_v1_tipo_documento.save
      json_response "Tipo documento guardado con exito", true, { result:  @api_v1_tipo_documento, pagination: [] }, 200 
    else
      respuesta =  @api_v1_tipo_documento.errors.full_messages
      json_response respuesta, false, {}, 422
    end
  end

  def update
    if @api_v1_tipo_documento.update(api_v1_tipo_documento_params)
      json_response "Tipo documento editado con exito", true, { result:  @api_v1_tipo_documento, pagination: [] }, 200 
    else
      respuesta =  @api_v1_tipo_documento.errors.full_messages
      json_response respuesta, false, {}, 422
    end
  end

  def destroy
    @api_v1_tipo_documento.destroy!
  end

  private
    def set_api_v1_tipo_documento
      @api_v1_tipo_documento = TipoDocumento.find(params[:id])
    end

    def api_v1_tipo_documento_params
      params.require(:tp_documento).permit(:nombre, :clave)
    end

    def authenticate_api_key!
      @key_validate = validate_authenticate_api_key
    end

    def valid_token
      @token_validate = validate_authenticate_token
    end
end
