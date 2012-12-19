# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#p_passliga').hide() if !$('#liga_privacidad_p').attr('checked')
  $('#contenttabliga input:radio').click ->
    $('#p_passliga').hide() if !$('#liga_privacidad_p').attr('checked')

  true