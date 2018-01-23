
$(function () {
// Document.ready -> link up remove event handler

    /*******************************
     **
     ** Gestion des dates avec DatTimePicker
     **
     *******************************/

    $('#stage_datedebut').datepicker({
        format: "dd/mm/yyyy",
        language: "fr",
        autoclose: true,
        todayHighlight: true
    });

    $('#stage_datefin').datepicker({
        format: "dd/mm/yyyy",
        language: "fr",
        autoclose: true,
        todayHighlight: true
    });

    function dateChange() {
        // var dateTest = new Date(2017, 10, 30);


        var strDate = $('#stage_datedebut').val();
        try {
            if (strDate != "") {
                var arrayDate = strDate.split('/');
                var dateDebut = new Date(arrayDate[2], arrayDate[1], arrayDate[0]);

                strDate = $('#stage_datefin').val();
                if (strDate != "") {
                    arrayDate = strDate.split('/');
                    var dateFin = new Date(arrayDate[2], arrayDate[1], arrayDate[0]);

                    /*var diff  = new Date(dateFin - dateDebut);
                     var days  = diff/1000/60/60/24;
                     var weeks = Math.ceil(days/7);*/

                    var interval = dateFin.getTime() - dateDebut.getTime();
                    var msecPerDay = 1000 * 60 * 60 * 24;
                    var days = Math.floor(interval / msecPerDay );
                    var weeks = Math.ceil(days/7);

                    $('#duree').val(weeks + " semaines");
                }
            }
        }
        catch(err) {
            $('#duree').val("");
        }
    }

    function deleteIntituleActivite() {
        // Obtention de la référence
        var idStage = $('#idStage').val();
        var oTR = $(this).parent().parent();
        var idIntitule = oTR.attr("idintitule");

        // Perform the ajax post
        $.post("/stage/deleteIntitule", { "idStage": idStage, "idIntitule": idIntitule },
            function (data) {
                // Successful requests get here
                // Update the page elements
                if (data.status == 1) {
                    var oTR = $('#intitule' + data.id);
                }
                else {
                    alert("L'activité n'a pas pu être retirée !")
                }
            }
        );
    }

    $('#stage_datedebut').bind('change', dateChange);
    $('#stage_datefin').bind('change', dateChange);

    $('a[name=deleteIntituleActivite]').bind('click', deleteIntituleActivite);


    /*******************************
     **
     ** Prévisualisation de l'image
     **
     *******************************/
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#entrepriseLogoPreview').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#stage_entrepriseLogo").change(function () {
        readURL(this);
    });
});
