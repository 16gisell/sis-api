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

    result = consulta.paginate(page: page, per_page: perPage)
    #objeto de paginacion
    objet_pagination = {}
    objet_pagination[:current_page] = page.to_i
    objet_pagination[:total] = consulta.length.to_i
    objet_pagination[:per_page] = perPage.to_i

    json_response "Listado de #{tabla}", true, { result: result, pagination: objet_pagination }, 200 
  end

  def objet_pagination_usuario(page_d, per_page_d, filter)
    page = page_d || 1
    perPage =  per_page_d || 10
    
    if filter.present? && !filter.blank? 
        # Si envia datos en el parametro filter
        consulta = Usuario.where("lower(numero_documento) LIKE ? OR lower(tipo_usuario_id) LIKE ? OR lower(tipo_documento_id)", "%#{filter.downcase}%", "%#{filter.downcase}%", "%#{filter.downcase}%").order("id ASC")
    else
        # No envia datos en el parametro filter
        consulta = Usuario.all.order("id ASC")
    end

    result = consulta.paginate(page: page, per_page: perPage)
    #objeto de paginacion
    objet_pagination = {}
    objet_pagination[:current_page] = page.to_i
    objet_pagination[:total] = consulta.length.to_i
    objet_pagination[:per_page] = perPage.to_i

    json_response "Lista usuarios", true, { result: result, pagination: objet_pagination }, 200 
  end
end