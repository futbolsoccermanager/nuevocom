module HomeHelper

  ACC_DASHBOARD = [
      %w(alineacion fichajes),
      %w(miliga clasificacion),
      %w(amigos nuevo_equipo)
  ]

  def dashboard_action(accion)
    case accion
      when 'alineacion'
        plantilla_selecciones_path(:id_seleccion => current_user.current_seleccion(session).id)
      when 'fichajes'
        mercado_path(current_user.current_seleccion(session))
      when 'miliga'
        '#'
      when 'clasificacion'
        clasificacion_index_path
      when 'amigos'
        usuarios_path
      when 'nuevo_equipo'
        new_selecciones_path
    end
  end
end
