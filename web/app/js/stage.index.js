
$(function () {
// Document.ready -> link up remove event handler

    function RemoveStage() {
        // Get the id from the link
        var oDiv = $(this).parent().parent();
        var id = oDiv.attr("id").substr(5);
        var oTD = oDiv.find('#libcourt');
        var libelle = oTD.html();

        if (id != '' && confirm("La suppression du stage '" + libelle + "' supprimera aussi les initulés et activités.\nConfirmer la suppression ?")) {
            $('#loader').show('slow', null);
            // Perform the ajax post
            $.post("/app_dev.php/stage/delete", { "idStage": id },
                function (data) {
                    // Successful requests get here
                    // Update the page elements
                    if (data.status == 1) {
                        $('#stage' + data.id).fadeOut('slow');
                        $('#update-message').attr("class", 'label label-success');

                        // Si le message "impossible d'ajouter des stages est présent, on l'enlève.
                        var oMessage = $('#maxStage');
                        if (oMessage.length) {
                            oMessage.hide();
                        }

                    }
                    else
                        $('#update-message').attr("class", 'label label-danger');
                    $('#loader').hide();
                    $('#update-message').text(data.message);
                    $('#update-message').show('slow', null).delay(3000).hide('slow');
                }
            );
        }
    }

    // Document.ready -> link up remove event handler
    $('a[name=deleteStage]').bind('click', RemoveStage);

});
