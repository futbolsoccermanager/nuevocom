# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#p_passliga').hide() if !$('#liga_privacidad_p').attr('checked')
  $('#contenttabliga input:radio').click ->
    if !$('#liga_privacidad_p').attr('checked')
      $('#p_passliga').hide()
    else
      $('#p_passliga').show()


  $('#slider-jugadores').slider({
    range: "max",
    min: 2,
    max: 20,
    value: 8,
    slide: ( event, ui ) ->
      $( "#liga_num_jugadores_mercado" ).val( ui.value )
      undefined
  } );
  $( "#liga_num_jugadores_mercado" ).val( $( "#slider-jugadores" ).slider( "value" ) );

  $('#slider-presupuesto').slider({
  range: "max",
  min: 30000000,
  max: 100000000,
  value: 50000000,
  slide: ( event, ui ) ->
    $( "#liga_presupuesto_inicial" ).val( ui.value )
    undefined
  } );
  $( "#liga_presupuesto_inicial" ).val( $( "#slider-presupuesto" ).slider( "value" ) );

  true