# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.rem_oferta').click ->
    idborrar = $(this).attr('id')
    idborrar = idborrar.substring(idborrar.indexOf('_'))
    $('#oferta'+idborrar).val('')
    true

  $('.makeofer').click ->
    errors = false
    $('.valofer').each ->
      if ($(this).val())
        if(!$.isNumeric($(this).val()))
          $(this).parent().parent().addClass('error')
          errors = true
        else
          $(this).parent().parent().addClass('info')
    if (!errors)
      $("#formofer").submit()
    false

  true
