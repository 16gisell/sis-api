class Api::V1::ApikeyController < ApplicationController
    def index        
        page = params[:page] || 1
        perPage = params[:per_page] || 10
        
        if params[:filter].present? && !params[:filter].blank? 
            # Si envia datos en el parametro filter
            consulta = Api::Apikey.where("lower(name) LIKE ? OR lower(email) LIKE ?", "%#{params[:filter].downcase}%", "%#{params[:filter].downcase}%").order("id ASC")
        else
            # No envia datos en el parametro filter
            consulta = Api::Apikey.all.order("id ASC")
        end
        begin
            result = consulta.paginate(page: page, per_page: perPage)
            #objeto de paginacion
            objet_pagination = {}
            objet_pagination[:current_page] = page.to_i
            objet_pagination[:total] = consulta.length.to_i
            objet_pagination[:per_page] = perPage.to_i

            if !result.blank?
                build_success "Lista api_key", { result: result, pagination: objet_pagination }
              else
                build_success_inactive "El listado de Lista api_key es vacio", { result: result, pagination: objet_pagination }
              end
        rescue
            build_error "Error de consulta api-key compruebe la solicitud"    
        end
    end

    def create
        @api = Api::Apikey.new(api_params)      
        begin  
            if @api.save
                build_success_create "api-key creada exitosamente"
            else
                respuesta =  @api.errors.full_messages
                build_error respuesta
            end
        rescue
            build_error "Error de consulta crear api-key compruebe la solicitud"    
        end
    end

    private

    def set_api
        @api = ApiKey.find params[:id]
    end

    def api_params
        params.require(:api).permit(:email, :name)
    end
end
