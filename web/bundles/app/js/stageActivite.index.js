
$(function () {

    function RemoveStageIntituleActiviteClick() {
        // Get the id from the link
        var tr = $(this).parent().parent();
        var td = tr.find("#intitule");
        var libelle = td.html();
        var id = tr.attr("id");
        var separator = id.indexOf("-");
        var idIntitule = id.substring(0, separator);
        var idStage = id.substring(separator +1);

        if (id != '' && confirm("Voulez-vous supprimer l'intitulé '" + libelle + "' ? ")) {
            $('#loader').show('slow', null);
            // Perform the ajax post
            $.post("/app_dev.php/stage/deleteIntitule", { "idStage": idStage, "idIntitule": idIntitule },
                function (data) {
                    // Successful requests get here
                    // Update the page elements
                    if (data.Status == 1) {
                        $('#' + id).fadeOut('slow');
                        $('#update-message').attr("class", 'label label-success');
                    }
                    else
                        $('#update-message').attr("class", 'label label-danger');
                    $('#update-message').text(data.Message);
                    $('#loader').hide();
                    $('#update-message').show('slow', null).delay(3000).hide('slow');
                }
            );
        }
    }

    // Document.ready -> link up remove event handler
    $('a[name=deleteStageIntituleActivite]').bind('click', RemoveStageIntituleActiviteClick);




    $("#btnAjoutSituation").click(function () {
        // Titre
        $("#situationModalTitle").text('Ajouter une situation professionnelle');
        // Boutton enabled sans icone
        $("#btnSituationValidate").attr("disabled", false);
        $('#iconBtnSituationValidate').removeClass();

        // initialize modal form
        $('#addModifySituation').modal('show');
    });


    function CreateIntituleActivite(newRow) {
        // Nombre de contributeurs
        var count = $('#listeIntituleActivites > tbody').children().length;

        if (count == 0) {
            // Obtention de la fin de liste
            var oTable = $('#listeIntituleActivites > tbody');
            // Ajout du row dans la table
            oTable.append(newRow);
        }
        else {
            // Obtention de la fin de liste
            var oCurrentTR = $('#listeIntituleActivites > tbody > tr:last');
            // Ajout du row dans la table
            oCurrentTR.after(newRow);
        }
        // Incremente le nombre d'activités citées
        count++;

        // Attache l'évènement onClick au dernier élément ajouté
        $('#listeIntituleActivites > tbody > tr:last #modifyStageActivite').bind('click', modifyStageActivite);

        // Mise à jour du nombre de contributeurs
        $('#nbIntitulesCites').html(count + "  situations professionnelles");
    }


    $("#btnActiviteValidate").click(function () {
        // modal form
        var form = $('#addModifyActivite');

        // Modification du bouton d'appel : grisé + spinner
        $('#btnActiviteValidate').attr("disabled", true);
        $('#iconBtnActiviteValidate').addClass('fa fa-spinner fa-spin');
        // Affichage du panel de status
        var panelStatus = form.find('#panelStatus');
        panelStatus.show();

        // Obtention des données
        var idStage = $("#modalIdStage").val();
        var idIntituleNext = $("#idintituleNext").val();
        var activites = form.find('#activites');
        var idActivite = activites.val();
        var modalIntitule = form.find('#modalIntitule');
        var intitule = modalIntitule.val();

        // Perform the ajax post
        $('#loader').show('slow', null);


        /*****************/
        /*    TEST       */
        //var data = { Status: 1, IntituleId: "1", ActiviteNomenclature: idActivite + " **TEST**  - Bla bla" };
        /*****************/
        $.post("/app_dev.php/stage/ajouterIntituleActivite", { "idStage": idStage, "idIntitule": idIntituleNext, "intitule": intitule, "idActivite": idActivite },
            function (data) {
                if (data.status == 1) {
                    $('#update-message').attr("class", 'label label-success');

                    $("#idintituleNext").val(idIntituleNext +1);
                    // Création du row

                    var newRow = "<tr id='" + data.idIntitule + "-" + idStage + "'>";
                    newRow += "<td width='60px'><a class='btn btn-xs' href='#' id='deleteStageIntituleActivite' name='deleteStageIntituleActivite' title='Supprimer'><i class='fa fa-trash-o fa-lg text-danger'></i></a>";
                    newRow += "<a class='btn btn-xs' href='#' id='modifyStageActivite' name='modifyStageActivite' title='Modifier'><span class='glyphicon glyphicon-pencil'></span></a></td>";
                    newRow += "<td id='intitule'>" + intitule + "</td>";
                    newRow += "<td id='activites'><p id='" + idActivite + "'>" + data.activiteNomenclature + "<p/></td>";
                    newRow += "</tr>";

                    CreateIntituleActivite(newRow);
                } else {
                    alert("L'activité n'a pas pu être créée : " + data.message);
                    $('#update-message').attr("class", 'label label-danger');
                }
            });

        $('#addModifyActivite').modal('hide')
    });


    // Document.ready -> link up remove event handler
    $('select[name=activites]').bind('click', ActivitesChange);

    function ActivitesChange() {
        var value = $(this).val();
        if (value == '0') {
            return;
        }

        var divParent = $(this).parent().parent().parent();

        var listeCompetences = divParent.find('#listeCompetences');
        // Vide le combobox
        listeCompetences.empty();

        var loadCompetences = divParent.find('#loadCompetences');
        // Perform the ajax post
        loadCompetences.show();

        $.post("/app_dev.php/competence/list/" + value, null,
            function (data) {
                // Successful requests get here
                // Update the page elements

                var listeCompetences = divParent.find('#listeCompetences');

                $.each(data.liste, function (index, value) {
                    listeCompetences.append("<option value='" + value.id + "'>" + value.nomenclature + " - " + value.libelle + "</option>");
                });

                loadCompetences.hide();
            });
    };


    /**********************************************
     ****
     ****                 MODIFICATION
     ****
     ***********************************************/

    function createSpanActiviteLibelle(libelle) {
        var libelleCourt = (libelle.length > 70 ? libelle.substring(0, 67) + " ..." : libelle);
        return '<span libelleLong="'+ libelle + '">' + libelleCourt + '</span>';
    }

    $('a[name=modifyStageActivite]').bind('click', modifyStageActivite);

    function modifyStageActivite() {
        // initialize modal form
        var form = $('#addModifyActivite');

        // Titre
        $("#activiteModalTitle").text('Modifier la situation professionnelle');
        // Boutton enabled sans icone
        $("#btnActiviteValidate").attr("disabled", false);
        $('#iconBtnActiviteValidate').removeClass();
        // Activités sélectionnées visible
        $('#modifyActivite').show();

        var listeCompetences = form.find('#listeCompetences');
        listeCompetences.empty();

        $('#modalActivites').empty();

        var activites = form.find('#activites');
        activites.prop("selectedIndex", 0);
        // On cache le panel de status
        var panelStatus = form.find('#panelStatus');
        panelStatus.hide();

        // Get the id from parent
        var tr = $(this).parent().parent();
        var td = tr.find("#intitule");
        var modalIntitule = form.find('#modalIntitule');
        modalIntitule.val(td.html());

        var id = tr.attr("id");
        var separator = id.indexOf("-");
        var idIntitule = id.substring(0, separator);
        $("#modalIdIntitule").val(idIntitule);
        var idStage = id.substring(separator + 1);
        $("#modalIdStage").val(idStage);

        // Liste des activités
        var nbActivites = 0;
        var tdActivites = tr.find("#activites");
        tdActivites.children('p').each(function (index) {
            var paragraphp = $(this);

            var html = "<span id='" + paragraphp.attr('id') + "' class='tag label label-info' status='0'>";
            html += createSpanActiviteLibelle(paragraphp.html()) + "<a name='deleteModalIntituleActivite' href='#'><i class='remove glyphicon glyphicon-remove-sign glyphicon-white'></i></a></span><br />";

            $('#modalActivites').append(html);
            nbActivites++;
        });
        $('#spanNbActivites').html(nbActivites);

        // Attache l'évènement onClick au dernier élément ajouté
        $('#modalActivites a[name=deleteModalIntituleActivite]').bind('click', removeStageActivite);


        $('#addModifyActivite').modal('show');
    };

    function removeStageActivite() {
        var span = $(this).parent();
        if (confirm("Voulez-vous supprimer l'activité ?")) {
            // Si l'attribut est égal à 1 cela signifie que l'on vient de l'ajouter ==> donc on le supprime
            // si == 0, l'attribut existe déjà, il faudra le supprimer donc on le cache
            if (span.attr("status") == "1") {
                span.remove();
            }
            else {
                span.attr("status", "-1");
                span.hide();
            }

            var nbActivites = parseInt($('#spanNbActivites').html());
            $('#spanNbActivites').html(nbActivites -1);
        }
    }


    $("#btnActiviteAdd").click(function () {
        // Obtient le nb d'activité
        var nbActivites = parseInt($('#spanNbActivites').html());
        // doit être inférieur ou égal à 5
        if (nbActivites >= 5) {
            alert("Le nombre d'activité ne doit pas être supérieur à 5 !");
            return;
        }

        // initialize modal form
        var form = $('#modifActivite');
        var activites = form.find('#Activites');
        var idActivite = activites.val();

        // Pas de doublons
        var spanDoublon = null;
        $('#modalActivites .tag').each(function () {
            if ($(this).attr('id') == idActivite) {
                spanDoublon = $(this);
            }
        });
        if (spanDoublon != null) {
            // Si le span est supprimé cela signifie qu'il existait avant donc on le réaffiche
            if (spanDoublon.attr("status") == "-1") {
                spanDoublon.attr("status", 0);
                spanDoublon.show();

                var nbActivites = parseInt($('#spanNbActivites').html());
                $('#spanNbActivites').html(nbActivites + 1);
            }
            else {
                // Sinon c'est un doublon
                alert("L'activité existe déjà !");
            };
            return;
        }


        var activiteLibelle = activites.find("option:selected").text();

        var html = "<span id='" + idActivite + "' class='tag label label-info' status='1'>";
        html += createSpanActiviteLibelle(activiteLibelle) + "<a name='deleteModalIntituleActivite' href='#'><i class='remove glyphicon glyphicon-remove-sign glyphicon-white'></i></a></span>";

        var newElement = $(html);
        $('#modalActivites').append(newElement);
        // Attache l'évènement onClick au dernier élément ajouté
        newElement.find('a').bind('click', removeStageActivite);

        // Tri de la liste
        var mylist = $('#modalActivites');
        var listitems = mylist.children('span').get();
        listitems.sort(function (a, b) {
            var aId = parseInt($(a).attr('id'));
            var bId = parseInt($(b).attr('id'));
            return (aId < bId) ? -1 : (aId > bId) ? 1 : 0;
        })
        $.each(listitems, function (idx, itm) { mylist.append(itm); });

        // Incrémente le nb d'activité
        $('#spanNbActivites').html(nbActivites + 1);
    });


    $("#btnActiviteValidate").click(function () {
        // initialize modal form
        var form = $('#addModifyActivite');

        // Modification du bouton d'appel : grisé + spinner
        $('#btnActiviteValidate').attr("disabled", true);
        $('#iconBtnActiviteValidate').addClass('fa fa-spinner fa-spin');
        // Affichage du panel de status
        var panelStatus = form.find('#panelStatus');
        panelStatus.show();

        // Obtention des données
        var idIntitule = $("#modalIdIntitule").val();
        var idStage = $("#modalIdStage").val();

        // Les activités
        var allActivites = "", listeActivites = "";
        $('#modalActivites .tag').each(function () {
            var spanTag = $(this);
            var status = $(this).attr("status");
            var idActivite = spanTag.attr('id');
            allActivites += idActivite + "," + status + ";";

            // Construction du html resultant de la validation des activités
            if (status != "-1") {
                var span = spanTag.find('span');
                listeActivites += "<p id='" + idActivite + "'>" + span.attr('libelleLong') + "</p>";
            }
        });

        $.post("/app_dev.php/stage/majIntituleActivite", { "idStage": idStage, "idIntitule": idIntitule, "allActivites": allActivites },
            function (data) {
                if (data.Status == 1) {
                    // Recherche du TR des activités
                    var tr = $("#" + idIntitule + "-" + idStage);
                    // Obtention du TD
                    var td = tr.find('#activites');
                    // Remplacement des activités
                    td.html(listeActivites);
                } else {
                    alert("Les activités n'ont pas pu être mises à jour : " + data.Message);
                }
            });

        $('#addModifyActivite').modal('hide')
    });

});