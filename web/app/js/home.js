
$(function () {
    // Document.ready -> link up remove event handler

    // Affichage des nombres de stages et de situations
    $('#loaderStages').show('slow', null);
    $('#loaderSituations').show('slow', null);
    // Stages
    $.post("/app_dev.php/stage/count", null,
        function (data) {
            // Successful requests get here
            // Update the page elements
            var oNbStages = $('#nbStages');
            oNbStages.text(data.count);
            if (data.count == 0) {
                oNbStages.attr("class", "badge badge-pill badge-danger");
                //$('#btnStageAdd').show();
            }
            else {
                $('#btnStageListe').show();
            }
            oNbStages.show();

            $('#loaderStages').hide();
        });

    // Situations
    $.post("/app_dev.php/situation/count", null,
        function (data) {
            // Successful requests get here
            var oNbSituations = $('#nbSituations');
            oNbSituations.text(data.count);
            if (data.count == 0) {
                oNbSituations.attr("class", "badge badge-pill badge-danger");
                //$('#btnSituationAdd').show();
            }
            else {
                $('#btnSituationListe').show();
            }
            // Update the page elements
            $('#loaderSituations').hide();
        });

});