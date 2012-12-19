module HomeHelper

  ACC_DASHBOARD = [
      %w(alineacion fichajes),
      %w(miliga clasificacion),
      %w(amigos nuevo_equipo)
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
      when 'nuevo_equipo'
        new_selecciones_path
    end
  end
end
