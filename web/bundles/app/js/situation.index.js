
$(function () {
// Document.ready -> link up remove event handler
    /*$('#SituationSearchCriteria_date').datepicker({
        format: "dd/mm/yyyy",
        language: "fr",
        autoclose: true,
        todayHighlight: true
    });*/


    $('button[id=btnDeleteSituation]').bind('click', RemoveSituationClick);

    function RemoveSituationClick() {
        // Récupération de la ligne en cours
        var oTR = $(this).parent().parent();
        // Récupération de l'id du film
        var refSituation= oTR.attr("id");
        // Récupération du libelle
        var oLibelle = oTR.find("#libelle");

        if (refSituation !== '' && confirm("Voulez-vous supprimer la situation '" + oLibelle.html() + "' ? "))
        {
            // CSS pour suppression
            oTR.attr('class','tr_removed');
            // Le bouton est grisé ...
            $(this).attr("disabled", true);
            // Le bouton Edit est aussi grisé
            var btnEdit = oTR.find("#btnDeleteSituation");
            btnEdit.attr("disabled", true);

            $.ajax({
                url: "/situation/delete",
                type: "post",
                data: { "refSituation": refSituation },
                success: function(data){
                    var oTR = $('#' + data.id);
                    var divMessage = $('#update-message');
                    if (data.status === 0) {
                        oTR.fadeOut('slow');
                        divMessage.attr("class", 'label label-success');
                    }
                    else {
                        divMessage.attr("class", 'label label-danger');
                        // On remet les valeurs de départ
                        // CSS pour suppression
                        oTR.attr('class','');
                        // Le bouton n'est pas grisé ...
                        var btnDelete = oTR.find("#btnDeleteSituation");
                        btnDelete.attr("disabled", false);
                    }
                    divMessage
                        .text(data.message)
                        .show('slow', null).delay(6000).hide('slow');
                },
                error:function(){
                    alert("Erreur d'accès à la méthode de suppression");
                    var oTR = $('#' + refSituation);
                    var btnDelete = oTR.find("#btnDeleteSituation");
                    oTR.attr('class','');
                    // Le bouton n'est pas grisé ...
                    btnDelete.attr("disabled", false);
                }
            });
        }
    }
});
