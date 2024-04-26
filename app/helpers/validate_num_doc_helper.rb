module ValidateNumDocHelper
  def validar_documento(documento_id, tipo_id, documento)
      tipo_usuario = TipoUsuario.find(tipo_id)
      tipo_documento = TipoDocumento.find(documento_id)

      if tipo_usuario[:clave] == "J" && tipo_documento[:clave] != "RIF"
        return {accion: false, menssage:"Las personas tipo juridico solo pueden ingresar su documento tipo rif"}
      else

        case tipo_documento[:clave]
        when "RIF"
            numero_documento = documento
            unless numero_documento =~ /^(J|P|G)-\d{8}-\d{1}$/
                return {accion: false, menssage:"Error el numero de documento no pertenece a un numero de rif valido"}
            else
                return {accion: true, menssage:""}
            end
        when "CI"
            ci_documento = documento.to_s.strip
            unless ci_documento =~/^([VE]){1}(\d{7,8})$/
                return {accion: false, menssage:"Error el numero de documento no pertenece a un numero de Cedula valido"}
            else
                return {accion: true, menssage:""}
            end
        when "PS"
            pasaporte_number = documento.to_s.strip
            unless pasaporte_number =~/^[A-Z]{2,4}\d{7,9}$/
                return {accion: false, menssage:"Error el numero de documento no pertenece a un numero de pasaporte valido"}
            else
                return {accion: true, menssage:""}
            end
        else
          return {accion: false, menssage:"Tipo de documento invalido: #{tipo_documento[:clave]}"}
            # raise ArgumentError, "Tipo de documento invalido: #{tipo_documento[:clave]}"
        end
      end
  end
end