# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.rem_oferta').live 'click', ->
    idborrar = $(this).attr('id')
    idborrar = idborrar.substring(idborrar.indexOf('_'))
    $('#oferta'+idborrar).val('')
    true

  $('.makeofer').live 'click', ->
    $("#delflag").val(false)
    errors = !$.isNumeric($(this).parent().find('input').val())
    if (!errors)
      $(this).parent().parent().submit()
    else
      $(this).parent().addClass('error')
    false

  $('.delofer').live 'click', ->
    $(".delflag").val(1)
    $(this).parent().parent().submit()
    false

  $('#fetchplayers').live 'click', ->
    $("#form_buscajugador").submit()
    false

  true

