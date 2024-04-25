module ValidateApikeyHelper
    #validamos si el enpoint tiene la llave de acceso
    def validate_authenticate_api_key
        api_key = request.headers['API-KEY']
        if api_key.present? && Api::Apikey.find_by(api_key_value: api_key).present?
            api_key = Api::Apikey.find_by(api_key_value: api_key)
            if api_key.valid?
                @key_validate = true
                return @key_validate
            else
                render json: { error: 'API key ha caducado' }, status: :unauthorized
            end            
        else
            render json: { error: 'API key inválida' }, status: :unauthorized
        end
    end

    # validamos si el header del enpint posee el token de sesion del usuario
    def validate_authenticate_token
        @admin = Admin.find_by authentication_token: request.headers["AUTH-TOKEN"]
      if @admin
        return @admin
      else
        json_response "Token de sesion invalido", false, {}, 422
      end
    end
end