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
    build_success "Tipo documento", { result:  @api_v1_tipo_documento, pagination: [] }
  end

  def create
    @api_v1_tipo_documento = TipoDocumento.new(api_v1_tipo_documento_params)
    begin
      if @api_v1_tipo_documento.save
        build_success_create "Tipo documento guardado con exito"
      else
        respuesta =  @api_v1_tipo_documento.errors.full_messages
        build_error respuesta
      end
    rescue
      build_error "Error de consulta crear tipo documento compruebe la solicitud"    
    end
  end

  def update
    begin
      if @api_v1_tipo_documento.update(api_v1_tipo_documento_params)
        build_success_content "Tipo documento editado con exito"
      else
        respuesta =  @api_v1_tipo_documento.errors.full_messages
        build_error respuesta
      end
    rescue
      build_error "Error de consulta crear tipo documento compruebe la solicitud"    
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
