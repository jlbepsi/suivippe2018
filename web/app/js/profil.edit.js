
$(function () {
// Document.ready -> link up remove event handler

    /*******************************
     **
     ** Gestion des dates avec DatTimePicker
     **
     *******************************/

    $('#utilisateur_datenaissance').datepicker({
        format: "dd/mm/yyyy",
        language: "fr",
        autoclose: true,
        todayHighlight: true
    });

});
