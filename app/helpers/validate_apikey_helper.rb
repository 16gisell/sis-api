module ValidateApikeyHelper
    #validamos si el enpoint tiene la llave de acceso
    def validate_authenticate_api_key        
        begin
            api_key = request.headers['API-KEY']
            if api_key.present? #&& Api::Apikey.find_by(api_key_value: api_key).present?
                api_key = Api::Apikey.find_by(api_key_value: api_key)
                if api_key.valid?
                    return true
                else
                    build_error_permisso 'API key ha caducado'
                end            
            else
                build_error_invalido 'API key inválida - Error de authorizacion'
            end
        rescue
            build_error "Error de consulta validacion api-key compruebe la solicitud"    
        end
    end

    # validamos si el header del enpint posee el token de sesion del usuario
    def validate_authenticate_token
        @admin = Admin.find_by authentication_token: request.headers["AUTH-TOKEN"]
        begin
            if @admin
                return @admin
            else
                build_error_invalido "Token de sesion invalido - Error de authorizacion"
            end
        rescue
            build_error "Error de consulta validacion api-token-authorizacion compruebe la solicitud"    
        end
    end
end