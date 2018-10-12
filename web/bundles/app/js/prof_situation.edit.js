
$(function () {
// Document.ready -> link up remove event handler

    function modifyCommentaire() {
        var modal = $('#newCommentaireModal');
        modal.find('.modal-title').text('Modifier un commentaire');

        var oTR = $(this).parent().parent();
        var oCommentaire = oTR.find("#commentaire");
        var idCommentaire = oTR.attr("id");
        $('#modalCommentaire').val(oCommentaire.html());
        $('#modalIdCommentaire').val(idCommentaire);

        modal.modal('show')
    }
    function ajouterCommentaire() {
        var modal = $('#newCommentaireModal');
        modal.find('.modal-title').text('Ajouter un commentaire');
        modal.modal('show');
    }

    function deleteCommentaire() {
        // Obtention de la référence
        var oTR = $(this).parent().parent();
        var idCommentaire = oTR.attr("id");
        $(this).attr("disabled", true);

        if (confirm("Confirmer la suppression du commentaire ?")) {
            // Perform the ajax post
            $.post("/app_dev.php/prof/situation/deletecommentaire", {"id": idCommentaire},
                function (data) {
                    // Successful requests get here
                    // Update the page elements
                    var oTR = $('#' + data.id);
                    if (data.status == 1) {
                        oTR.hide();
                    }
                    else {
                        var oBtn = oTR.find('#btnDeleteCommentaire');
                        oBtn.attr("disabled", false);

                        alert("Le commentaire n'a pas pu être retiré !")
                    }
                }
            );
        }
    }
    $('button[name=btnModifyCommentaire]').bind('click', modifyCommentaire);
    $('button[name=btnDeleteCommentaire]').bind('click', deleteCommentaire);

    $('button[id=btnNewCommentaireModal]').bind('click', ajouterCommentaire);

    /*
     *
     * Fenetre Modale
     *
     */
    $('#newCommentaireModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var modal = $(this)
        modal.find('.newCommentaireModalLabel').text((button.id=='btnNewCommentaireModal' ? 'Ajouter' : 'Modifier') + ' un commentaire')
    })

    $('#btnAjouterCommentaireModal').click( function () {
        var refSituation = $('#situationReference').val();
        var commentaire = $('#modalCommentaire').val();

        $('#newCommentaireModal').modal('hide');

        var idCommentaire = $('#modalIdCommentaire').val();
        if (idCommentaire == "0") {
            // Traitement pour l'ajout
            // Bouton grisé
            $('#btnNewCommentaireModal').attr("disabled", true);

            $.ajax({
                url: "/app_dev.php/prof/situation/addcommentaire",
                type: "post",
                data: {"refSituation": refSituation, "commentaire": commentaire},
                success: function (data) {
                    if (data.status == 1) {

                        var newRow = "<tr id='" + data.id + "'><td id='date'>" + data.date + "</td><td>" + data.prof + "</td>";
                        newRow += "<td id='commentaire'>" + data.commentaire + "</td>";
                        newRow += "<button id='btnModifyCommentaire' name='btnModifyCommentaire' type='button' class='btn btn-sm btn-default' aria-label='Modifier le commentaire'>" +
                            "<i class='fa fa-edit' aria-hidden='true'></i>&nbsp;Modifier</button>";
                        newRow += "<td><button id='btnDeleteCommentaire' name='btnDeleteCommentaire' type='button' class='btn btn-sm btn-danger'" +
                            " aria-label='Supprimer le commentaire'><i class='fa fa-trash' aria-hidden='true'></i>&nbsp;Supprimer" +
                            "</button></td></tr>";

                        // Obtention de la fin de liste
                        var oTable = $('#listeCommentaires > tbody');
                        // Ajout du row dans la table
                        oTable.append(newRow);

                        // Attache l'évènement onClick au dernier élément ajouté
                        $('#listeCommentaires > tbody > tr:last #btnModifyCommentaire').bind('click', modifyCommentaire);
                        $('#listeCommentaires > tbody > tr:last #btnDeleteCommentaire').bind('click', deleteCommentaire);

                    }
                    else {
                        alert(data.message)
                        $('btnNewCommentaireModal').attr("disabled", false);
                    }
                },
                error: function () {
                    alert("Erreur d'accès à la méthode d'ajout");
                    // Le bouton n'est pas grisé ...
                    $('btnNewCommentaireModal').attr("disabled", false);
                }
            });
        } else {
            // Traitement pour la modification
            // Bouton grisé
            var oTR = $('#' + idCommentaire);
            var btnModifyCommentaire = oTR.find("#btnModifyCommentaire");
            btnModifyCommentaire.attr("disabled", true);

            $.ajax({
                url: "/app_dev.php/prof/situation/modifycommentaire",
                type: "post",
                data: {"id": idCommentaire, "commentaire": commentaire},
                success: function (data) {
                    var oTR = $('#' + data.id);
                    var btnModifyCommentaire = oTR.find("#btnModifyCommentaire");
                    btnModifyCommentaire.attr("disabled", false);

                    if (data.status == 1) {
                        var oCommentaire = oTR.find("#commentaire");
                        oCommentaire.html(data.commentaire);
                        var odDate = oTR.find("#date");
                        odDate.html(data.date);
                    }
                    else {
                        alert(data.message)
                    }
                },
                error: function () {
                    alert("Erreur d'accès à la méthode de modifcation");
                    // Le bouton n'est pas grisé ...
                    var oTR = $('#' + idCommentaire);
                    var btnModifyCommentaire = oTR.find("#btnModifyCommentaire");
                    btnModifyCommentaire.attr("disabled", false);
                }
            });

        }
    });

});
