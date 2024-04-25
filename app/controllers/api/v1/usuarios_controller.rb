class Api::V1::UsuariosController < ApplicationController
  include ValidateApikeyHelper
  include ValidateNumDocHelper
  include PaginacionHelper
  before_action :authenticate_api_key!
  before_action :valid_token
  before_action :set_api_v1_usuario, only: %i[ show update destroy ]

  def index
    objet_pagination_usuario(params[:page], params[:per_page], params[:filter])
  end

  
  def show
    json_response "Usuario", true, { result: @api_v1_usuario, pagination: [] }, 200 
  end

  
  def create
    @api_v1_usuario = Usuario.new(api_v1_usuario_params)
        #validamos el numero de documento
    validar_doc = validar_documento(@api_v1_usuario[:tipo_documento_id], @api_v1_usuario[:tipo_usuario_id], @api_v1_usuario[:numero_documento])
      puts ap validar_doc
      puts "aquii"
    if validar_doc[:accion]
      if @api_v1_usuario.save
        json_response "Usuario registrado correctamente", true, { usuario: @api_v1_usuario }, 200
      else
        respuesta =  @api_v1_usuario.errors.full_messages
        json_response respuesta, false, {}, 422
      end
    else
      json_response validar_doc[:menssage], false, {  }, 422
    end
  end


  def update
    if @api_v1_usuario.update(api_v1_usuario_params)
      json_response "Usuario Actualizado correctamente", true, { usuario: @api_v1_usuario }, 200
    else
      respuesta =  @api_v1_usuario.errors.full_messages
      json_response respuesta, false, {}, 422
    end
  end

  
  def destroy
    @api_v1_usuario.destroy!
  end

  private

    def set_api_v1_usuario
      @api_v1_usuario = Usuario.find(params[:id])
    end

    def api_v1_usuario_params
      params.require(:usuario).permit(:nombre, :razon_social, :correo, :telefono_principal, :telefono_secundario, :numero_documento, :fecha_emicion_doc, :fecha_vencimiento_doc, :tipo_usuario_id, :tipo_documento_id)
    end

    def authenticate_api_key!
      @key_validate = validate_authenticate_api_key
    end

    def valid_token
      @token_validate = validate_authenticate_token
    end
end
