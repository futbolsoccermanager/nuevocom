# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Informa = {
init: ->
  this.initializePlaceholders
  true



initializePlaceholders: ->
  true if !$.fn.placeholder

  $('.text').placeholder()
  $("form").submit ->
    elements = $(this).find ".text[placeholder]"
    elements.each ->
      placeholder = $(this).attr 'placeholder'
      if  placeholder == $(this).val
        $(this).val ''
    true

  true
}


Informa.init()