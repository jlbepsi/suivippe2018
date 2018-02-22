
$(function () {
    // Document.ready -> link up remove event handler

    // Affichage des nombres de commentaires et de situations
    $('#loaderSituations').show('slow', null);
    // Affichage pour les stages
    $('#loaderStages').show('slow', null);

    // Stages
    $.post("prof/stage/analyse", null,
        function (data) {
            // Successful requests get here
            // Update the page elements
            var oNbStages = $('#nbStages');
            oNbStages.text(data.nbStages);
            if (data.nbStages == 0) {
                oNbStages.attr("class", "badge badge-pill badge-danger");
            } else {
                $('#nbUtilisateursSansStage').text(data.nbUtilisateursSansStage);
                $('#nbStagesIncomplets').text(data.nbStagesIncomplets);
                $('#btnStageListe').show();
            }

            $('#loaderStages').hide();
        });

    // Situations
    $.post("prof/situation/analyse", null,
        function (data) {
            // Successful requests get here
            var oNbSituations = $('#nbSituations');
            oNbSituations.text(data.nbSituations);
            if (data.nbSituations == 0) {
                oNbSituations.attr("class", "badge badge-pill badge-danger");
            } else {
                $('#nbCommentaires').text(data.nbCommentaires);
                $('#nbUtilisateursSansSituation').text(data.nbUtilisateursSansSituation);
                $('#nbSituationsIncompletes').text(data.nbSituationsIncompletes);
                $('#btnSituationListe').show();
            }
            // Update the page elements
            $('#loaderSituations').hide();
        });

});