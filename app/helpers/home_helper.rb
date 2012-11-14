module HomeHelper

  ACC_DASHBOARD = [
      %w(alineacion fichajes),
      %w(miliga clasificacion),
      %w(amigos)
  ]

  def dashboard_action(accion)
    case accion
      when 'alineacion'
        '#'
      when 'fichajes'
        mercado_path(current_user.current_seleccion(session))
      when 'miliga'
        '#'
      when 'clasificacion'
        '#'
      when 'amigos'
        '#'
    end
  end
end
