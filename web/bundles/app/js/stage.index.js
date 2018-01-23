
$(function () {
// Document.ready -> link up remove event handler

    function RemoveStage() {
        // Get the id from the link
        var oDiv = $(this).parent().parent();
        var id = oDiv.attr("id");
        var libelle = oDiv.attr("libcourt");

        if (id != '' && confirm("Voulez-vous supprimer le stage '" + libelle + "' ? ")) {
            $('#loader').show('slow', null);
            // Perform the ajax post
            $.post("/stage/delete", { "id": id },
                function (data) {
                    // Successful requests get here
                    // Update the page elements
                    if (data.Status == 1) {
                        $('#' + id).fadeOut('slow');
                        oDiv.parent().remove();
                        $('#update-message').attr("class", 'label label-success');
                    }
                    else
                        $('#update-message').attr("class", 'label label-danger');
                    $('#loader').hide();
                    $('#update-message').text(data.Message);
                    $('#update-message').show('slow', null).delay(3000).hide('slow');
                }
            );
        }
    }

    // Document.ready -> link up remove event handler
    $('a[name=deleteStage]').bind('click', RemoveStage);

});
