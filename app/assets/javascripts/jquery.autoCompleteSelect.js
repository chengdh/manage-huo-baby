/*!
 * jQuery Auto Complete Select
 *
 * Copyright (c) 2010 Camilo Nova (http://axiacore.com/)
 *
 * $Id: $
 *
 * Depends:
 *  jQuery 1.4
 */
jQuery.fn.autoCompleteSelect = function(params) {
  settings = jQuery.extend({
     removeFirst: true,
     setFocus: false,
     onResult: function() {}
  }, params);

  return this.each(function(){
    if (this.tagName.toLowerCase() != 'select') { return; }

    selector = this.id;
    auto_field = 'auto_'+selector;
    $('#'+selector).before("<input type='text' id='"+auto_field+"'></input>");
    $('#'+auto_field).width($('#'+selector).width());
    $('#'+selector).hide();

    data = [];
    $('#'+selector+' option').each(function(index) {
      // Cargamos el contenido del DOM en el array
      data.push($(this).text());
    });

    if(settings.removeFirst){
      // Quitamos el primer elemento del array. No del DOM
      data.shift();
    }
    
    // Mostramos en la caja de texto el valor seleccionado en caso de haber uno
    $('#'+auto_field).val($('#'+selector+' :selected').text());
  
    $('#'+auto_field).autocomplete({
      source: data,
      select: function(event, ui) {
        // Actualizamos el DOM con la opcion seleccionada del array
        selected = $('#'+selector+' option:contains('+ui.item.value+')').val();
        $('#'+selector).val(selected);
        $('#'+auto_field).css('border', '2px solid lightgreen');
        
        // Llamamos el metodo auxiliar recibido por parametro
        settings.onResult(ui.item.value);
      }
    });
  
    //Validamos que si exista una opcion en el listado
    $('#'+auto_field).blur(function() {
      val = $('#'+auto_field).val();
      if (val.length == 0 || $('#'+selector+' option:contains('+val+')').length == 0) {
        //No existe la opcion en el listado original
        $('#'+auto_field).css('border', '2px solid red');
        $('#'+selector).val(0);
      }
    });
  
    if (settings.setFocus) {
      $('#'+auto_field).select();
    }
  });
};