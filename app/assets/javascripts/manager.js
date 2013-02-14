FutbolSoccerManager= {

  ie6: /MSIE 6/i.test(navigator.userAgent),

  /* Initializer */
  init: function() {

    this.initializeDragAndDrop();

  },

    initializeDragAndDrop: function() {
        $(function() {
          $.each([".port", ".def",".med", ".del"], function(index, value) {
            $(value).draggable({
                cursor: 'move',        // sets the cursor apperance
                opacity: 0.35,         // opacity fo the element while it's dragged
                revert: true,          // sets the element to return to its start location
                revertDuration: 500

            });
          });
          var arr_dragables = [".port", ".def",".med", ".del"];
          $.each([".portero", ".defensa",".medio", ".delantero"], function(index, value) {
            $(value).droppable({
              accept: arr_dragables[index],
              drop: function(event, ui) {
                if ($(this).children()){
                  //$(this).children().insertAfter($(ui.draggable)); // con esto se metia la interrogante al banquillo
                  $(this).children().remove();
                }
                $(this).append($(ui.draggable));
                var id_jugador = $(ui.draggable).attr('id');
                $('span[id=delete_'+id_jugador+']').show();
                $('span[id=delete_'+id_jugador+']').click(function(){
                   id_remove = $(this).attr('id');
                   var id = id_remove.replace("delete_","");
                   var html_jugador = $('#'+id).html();
                   if ($('#'+id).attr('class').indexOf("port") >= 0){
                     html_jugador = "<div id=" + "'" + id + "'" + " class='jugador-alineacion port anadir ui-draggable' style='position: relative;'>" + html_jugador + "</div>";
                     $('#'+id).before($('#hide_portero').html());
                     $('.banco-portero').prepend(html_jugador);
                   } else if ($('#'+id).attr('class').indexOf("def") >= 0){
                     html_jugador = "<div id=" + "'" + id + "'" + " class='jugador-alineacion def anadir ui-draggable' style='position: relative;'>" + html_jugador + "</div>";
                     $('#'+id).before($('#hide_defensa').html());
                     $('.banco-defensa').prepend(html_jugador);
                   } else if ($('#'+id).attr('class').indexOf("med") >= 0){
                     html_jugador = "<div id=" + "'" + id + "'" + " class='jugador-alineacion med anadir ui-draggable' style='position: relative;'>" + html_jugador + "</div>";
                     $('#'+id).before($('#hide_medio').html());
                     $('.banco-medio').prepend(html_jugador);
                   } else if ($('#'+id).attr('class').indexOf("del") >= 0){
                     html_jugador = "<div id=" + "'" + id + "'" + " class='jugador-alineacion del anadir ui-draggable' style='position: relative;'>" + html_jugador + "</div>";
                     $('#'+id).before($('#hide_delantero').html());
                     $('.banco-delantero').prepend(html_jugador);
                   }
                   $('span[id=delete_'+id+']').hide();
                   $('#'+id).remove();
                });

              }
            });
          });
        });
    }




}


FutbolSoccerManager.init();