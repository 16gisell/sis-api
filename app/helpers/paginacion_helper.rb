module PaginacionHelper

  def objet_pagination(page_d, per_page_d, filter, tabla)
    page = page_d|| 1
    perPage = per_page_d|| 10
    
    if filter.present? && !filter.blank? 
        # Si envia datos en el parametro filter
        consulta = tabla.where("lower(nombre) LIKE ? OR lower(clave) LIKE ?", "%#{filter.downcase}%", "%#{filter.downcase}%").order("id ASC")
    else
        # No envia datos en el parametro filter
        consulta = tabla.all.order("id ASC")
    end
    begin
      result = consulta.paginate(page: page, per_page: perPage)
      #objeto de paginacion
      objet_pagination = {}
      objet_pagination[:current_page] = page.to_i
      objet_pagination[:total] = consulta.length.to_i
      objet_pagination[:per_page] = perPage.to_i
      if !result.blank?
          build_success "Lista #{tabla}", { result: result, pagination: objet_pagination }
        else
          build_success_inactive "El listado de #{tabla} es vacio", { result: result, pagination: objet_pagination }
        end
      rescue
        build_error "Error de consulta compruebe la solicitud"    
      end

  end

  def objet_pagination_usuario(page_d, per_page_d, filter)
    page = page_d || 1
    perPage =  per_page_d || 10
    
    if filter.present? && !filter.blank? 
        # Si envia datos en el parametro filter
        consulta = Usuario.where("lower(numero_documento) LIKE ?", "%#{filter.downcase}%").order("id ASC")
    else
        # No envia datos en el parametro filter
        consulta = Usuario.all.order("id ASC")
    end
    begin
      result = consulta.paginate(page: page, per_page: perPage)
        #objeto de paginacion
        objet_pagination = {}
        objet_pagination[:current_page] = page.to_i
        objet_pagination[:total] = consulta.length.to_i
        objet_pagination[:per_page] = perPage.to_i

        if !result.blank?
          build_success "Lista usuarios", { result: result, pagination: objet_pagination }
        else
          build_success_inactive "El listado de usuario es vacio", { result: result, pagination: objet_pagination }
        end
      rescue
        build_error "Error de consulta usuarios compruebe la solicitud"    
      end
  end
end