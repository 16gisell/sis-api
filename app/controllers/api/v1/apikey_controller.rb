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

        result = consulta.paginate(page: page, per_page: perPage)
        #objeto de paginacion
        objet_pagination = {}
        objet_pagination[:current_page] = page.to_i
        objet_pagination[:total] = consulta.length.to_i
        objet_pagination[:per_page] = perPage.to_i

        json_response "Lista api_key", true, { result: result, pagination: objet_pagination }, 200 
    end

    def create
        @api = Api::Apikey.new(api_params)        
        if @api.save
            json_response "api key", true, { result: @api }, 200
        else
            json_response "Error al crear api_key o correo ya ha sido registrado", false, {}, 422
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
