
$(function () {
// Document.ready -> link up remove event handler

    $('button[id=btnDeleteUtilisateur]').bind('click', DeleteUtilisateurClick);

    function DeleteUtilisateurClick() {
        // Récupération de la ligne en cours
        var oTR = $(this).parent().parent();
        // Récupération du login de l'utilisateur
        var login= oTR.attr("id");

        if (login !== '' && confirm("La suppression de l'utilisateur '" + login + "' supprimera aussi tous ses stages et situations.\nConfirmer la suppression ?")) {
            // CSS pour suppression
            oTR.attr('class','tr_removed');
            // Le bouton est grisé ...
            $(this).attr("disabled", true);
            // Le bouton Supprimer est aussi grisé
            var btnEdit = oTR.find("#btnDeleteUtilisateur");
            btnEdit.attr("disabled", true);

            $.ajax({
                url: "/app_dev.php/utilisateurs/delete",
                type: "post",
                data: { "login": login },
                success: function(data){
                    var oTR = $('#' + data.id.replace(/\./g, '\\.'));
                    var divMessage = $('#update-message');
                    if (data.status === 1) {
                        oTR.fadeOut('slow');
                        divMessage.attr("class", 'label label-success');
                    }
                    else {
                        divMessage.attr("class", 'label label-danger');
                        // On remet les valeurs de départ
                        // CSS pour suppression
                        oTR.attr('class','');
                        // Le bouton n'est pas grisé ...
                        var btnDelete = oTR.find("#btnDeleteUtilisateur");
                        btnDelete.attr("disabled", false);
                    }
                    divMessage
                        .text(data.message)
                        .show('slow', null).delay(6000).hide('slow');
                },
                error:function(){
                    alert("Erreur d'accès à la méthode de suppression");
                    var oTR = $('#' + login.replace(/\./g, '\\.'));
                    var btnDelete = oTR.find("#btnDeleteUtilisateur");
                    oTR.attr('class','');
                    // Le bouton n'est pas grisé ...
                    btnDelete.attr("disabled", false);
                }
            });
        }
    }

});