module OfertasHelper
  def clase_oferta(estado)
    case estado
      when Oferta::PENDIENTE
        'warning'
      when Oferta::ACEPTADA
        'success'
      when Oferta::CADUCADA
        'error'
      when Oferta::RECHAZADA
        'error'
      when Oferta::CANCELADA
        'error'
      else
        ''
    end
  end
end
