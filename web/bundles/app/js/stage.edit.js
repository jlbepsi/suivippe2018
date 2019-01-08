
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
        calendarWeeks: true,
        todayHighlight: true
    });

    $('#stage_datefin').datepicker({
        format: "dd/mm/yyyy",
        language: "fr",
        autoclose: true,
        calendarWeeks: true,
        todayHighlight: true
    });

    // Mise à jour de la durée
    dateChange();

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

        if (confirm("La suppression de l'intitulé supprimera aussi les activités.\nConfirmer la suppression ?")) {
            var btnDelete = oTR.find("#deleteIntituleActivite");
            btnDelete.attr("disabled", true);

            $.ajax({
                url: "/app_dev.php/stage/deleteIntitule",
                type: "post",
                data: {"idStage": idStage, "idIntitule": idIntitule},
                success: function (data) {
                    var divMessage = $('#update-message');
                    // Successful requests get here
                    // Update the page elements
                    var oTR = $('#intitule' + data.idStage + '-' + data.idIntitule);
                    if (data.status == 1) {
                        oTR.fadeOut('slow');
                        divMessage.attr("class", 'label label-success');
                    }
                    else {
                        divMessage.attr("class", 'label label-danger');
                        // On remet les valeurs de départ
                        // CSS pour suppression
                        oTR.attr('class', '');
                        // Le bouton n'est pas grisé ...
                        var btnDelete = oTR.find("#deleteIntituleActivite");
                        btnDelete.attr("disabled", false);
                    }
                    divMessage
                        .text(data.message)
                        .show('slow', null).delay(6000).hide('slow');
                },
                error: function () {
                    alert("Erreur d'accès à la méthode de suppression");
                    var oTR = $('#intitule' + idStage + '-' + idIntitule);
                    var btnDelete = oTR.find("#deleteIntituleActivite");
                    oTR.attr('class', '');
                    // Le bouton n'est pas grisé ...
                    btnDelete.attr("disabled", false);
                }
            });
        }
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


    $('#btnAjouterIntituleModal').click( function () {
        var idStage = $('#idStage').val();
        var intitule = $('#modalIntitule').val();

        $('#newIntituleModal').modal('hide');
        // Bouton grisé
        $('#btnNewIntituleModal').attr("disabled", true);

        // Traitement
        $.ajax({
            url: "/app_dev.php/stage/addIntitule",
            type: "post",
            data: { "idStage" : idStage, "intitule": intitule },
            success: function(data){
                var divMessage = $('#update-message');
                if (data.status == 1) {
                    divMessage.attr("class", 'label label-success');

                    var newRow = "<tr id='intitule" + data.idStage + '-' + data.idIntitule + "' idintitule='" + data.idIntitule + "'><td>" + data.intitule + "</td>";
                    newRow += "<td></td><td>";
                    newRow += "<a class='btn btn-primary btn-sm' href='/app_dev.php/stage/editIntitule/" + data.idStage + "/" + data.idIntitule + "' title='Modifier intitulé'><i class='fa fa-pencil-alt' aria-hidden='true'></i>&nbsp;Modifier</a>&nbsp;";
                    newRow += "<a class='btn btn-danger btn-sm' href='#' id='deleteIntituleActivite' name='deleteIntituleActivite' title='Supprimer intitulé'><i class='fa fa-trash-alt' aria-hidden='true'></i>&nbsp;Supprimer</a>";
                    newRow += "</td></tr>";

                    // Obtention de la fin de liste
                    var oTable = $('#listeActivites > tbody');
                    // Ajout du row dans la table
                    oTable.append(newRow);

                    // Attache l'évènement onClick au dernier élément ajouté
                    $('#listeActivites > tbody > tr:last #deleteIntituleActivite').bind('click', deleteIntituleActivite);

                    // Bouton normal
                    $('#btnNewIntituleModal').attr("disabled", false);

                    // On enlève la ligne indiquant "aucun intitulé"
                    var oTD = $("#aucunItitule");
                    if (oTD != "undefined") {
                        oTD.hide();
                    }

                }
                else {
                    divMessage.attr("class", 'label label-danger');
                    $('#btnNewIntituleModal').attr("disabled", false);
                    divMessage
                        .text(data.message)
                        .show('slow', null).delay(6000).hide('slow');
                }
            },
            error:function(){
                alert("Erreur d'accès à la méthode de suppression");
                // Le bouton n'est pas grisé ...
                $('#btnNewIntituleModal').attr("disabled", false);
            }
        });
    });
});
