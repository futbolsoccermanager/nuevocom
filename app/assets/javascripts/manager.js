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
                  revert: true
                });
              });
              var arr_dragables = [".port", ".def",".med", ".del"];
              $.each([".portero", ".defensa",".medio", ".delantero"], function(index, value) {
                $(value).droppable({
                  accept: arr_dragables[index],
                  drop: function(event, ui) {
                    if ($(this).children()){
                      $(this).children().insertAfter($(ui.draggable));
                    }
                    $(this).append($(ui.draggable));
                  }
                });
              });
        });
    }


}


FutbolSoccerManager.init();