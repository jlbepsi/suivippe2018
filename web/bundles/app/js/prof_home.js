
$(function () {
    // Document.ready -> link up remove event handler

    // Affichage des nombres de commentaires et de situations
    $('#loaderCommentaires').show('slow', null);
    $('#loaderSituations').show('slow', null);
    // Stages
    $.post("prof/situation/countcomment", null,
        function (data) {
            // Successful requests get here
            // Update the page elements
            var oNbCommentaires = $('#nbCommentaires');
            oNbCommentaires.text(data.count);
            if (data.count == 0) {
                oNbCommentaires.attr("class", "badge badge-pill badge-danger");
                //$('#btnStageAdd').show();
            }
            oNbCommentaires.show();

            $('#loaderCommentaires').hide();
        });

    // Situations
    $.post("prof/situation/count", null,
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