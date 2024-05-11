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
    build_success "Tipo personas", { result:  @api_v1_tipo_usuario, pagination: [] }
  end


  def create
    @api_v1_tipo_usuario = TipoUsuario.new(api_v1_tipo_usuario_params)
    begin
      if @api_v1_tipo_usuario.save
        build_success_create "Tipo personas guardado con exito"
      else
        respuesta =  @api_v1_usuario.errors.full_messages
        build_error respuesta
      end
    rescue
      build_error "Error de consulta crear tipo persona compruebe la solicitud"    
    end
  end

  def update
    begin
      if @api_v1_tipo_usuario.update(api_v1_tipo_usuario_params)
        build_success_content "Tipo personas Actualizado con exito"
      else
        respuesta =  @api_v1_usuario.errors.full_messages
        build_error respuesta
      end
    rescue
      build_error "Error de consulta editar tipo persona compruebe la solicitud"    
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
