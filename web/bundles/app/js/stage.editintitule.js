
$(function () {
// Document.ready -> link up remove event handler


    function deleteStageIntituleActivite() {
        // Obtention de la référence
        var idstage = $('#stageId').val();
        var idintitule = $('#intituleId').val();
        var oTR = $(this).parent().parent();
        var activiteId = oTR.attr("activiteId");

        // Perform the ajax post
        $.post("/app_dev.php/stage/removeactivite", { "id": activiteId, "idstage": idstage, "idintitule": idintitule },
            function (data) {
                // Successful requests get here
                // Update the page elements
                if (data.status == 1) {
                    var oTR = $('#activite' + data.idActivite);
                    oTR.attr('class', 'tr_nonactif');
                    var spanok = oTR.find('#spanok');
                    spanok.hide();
                    var oRetirer = oTR.find('#deleteStageIntituleActivite');
                    oRetirer.hide();
                    var oAjouter = oTR.find('#addStageIntituleActivite');
                    oAjouter.show();

                    if ($('#showStageActivitiesOnly').prop('checked')) {
                        oTR.hide();
                    }
                }
                else {
                    alert("L'activité n'a pas pu être retirée !")
                }
            }
        );
    }

    function addStageIntituleActivite() {
        // Obtention de la référence
        var idstage = $('#stageId').val();
        var idintitule = $('#intituleId').val();
        var oTR = $(this).parent().parent();
        var activiteId = oTR.attr("activiteId");

        // Perform the ajax post
        $.post("/app_dev.php/stage/addactivite", { "id": activiteId, "idstage": idstage, "idintitule": idintitule },
            function (data) {
                // Successful requests get here
                // Update the page elements
                if (data.status == 1) {
                    var oTR = $('#activite' + data.idActivite);
                    oTR.attr('class', 'tr_actif');
                    var spanok = oTR.find('#spanok');
                    spanok.show();
                    var oRetirer = oTR.find('#deleteStageIntituleActivite');
                    oRetirer.show();
                    var oAjouter = oTR.find('#addStageIntituleActivite');
                    oAjouter.hide();
                }
                else {
                    alert("L'activité n'a pas pu être ajoutée !")
                }
            }
        );
    }

    $('#showStageActivitiesOnly').click( function () {

        if ($(this).prop('checked')) {
            $("#listeActivites > tbody > tr.tr_nonactif").each(function() {
                var tr = $(this);
                tr.hide();
            });
        } else {
            $("#listeActivites > tbody > tr").each(function() {
                var tr = $(this);
                tr.show();
            });
        }
    });

    $('a[name=addStageIntituleActivite]').bind('click', addStageIntituleActivite);
    $('a[name=deleteStageIntituleActivite]').bind('click', deleteStageIntituleActivite);

});
