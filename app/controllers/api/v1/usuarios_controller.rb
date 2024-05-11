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
    build_success "Usuario", { result: @api_v1_usuario, pagination: [] }
  end

  
  def create
    @api_v1_usuario = Usuario.new(api_v1_usuario_params)
        #validamos el numero de documento
    validar_doc = validar_documento(@api_v1_usuario[:tipo_documento_id], @api_v1_usuario[:tipo_usuario_id], @api_v1_usuario[:numero_documento])
    begin
      if validar_doc[:accion]
        if @api_v1_usuario.save
          build_success_create "Usuario registrado correctamente"
        else
          respuesta =  @api_v1_usuario.errors.full_messages
          build_error respuesta
        end
      else
        build_error validar_doc[:menssage]
      end
    rescue
      build_error "Error de consulta crear usuario compruebe la solicitud"    
    end
  end


  def update
    begin
      if @api_v1_usuario.update(api_v1_usuario_params)
        build_success_content "Usuario Actualizado correctamente"
      else
        respuesta =  @api_v1_usuario.errors.full_messages
        build_error respuesta
      end
    rescue
      build_error "Error de consulta crear usuario compruebe la solicitud"    
    end
  end

  
  def destroy
    # @api_v1_usuario.destroy!
    begin
      if  @api_v1_usuario.destroy!
        build_success_content "Usuario Eliminado correctamente"
      else
        respuesta =  @api_v1_usuario.errors.full_messages
        build_error respuesta
      end
    rescue
      build_error "Error de consulta crear usuario compruebe la solicitud"    
    end
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
