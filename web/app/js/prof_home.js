
$(function () {
    // Document.ready -> link up remove event handler

    // Affichage des nombres de commentaires et de situations
    $('#loaderSituations').show('slow', null);
    // Affichage pour les stages
    $('#loaderStages').show('slow', null);


    function drawChartStage(nbUtilisateurs, nbStages, nbUtilisateursSansStage, nbStagesIncomplets) {
        var ctx = document.getElementById("chartjs-stageEtudiant").getContext('2d');
        new Chart(ctx,
            {
                "type":"pie",
                "data":
                    {
                        "labels":["Avec stage", "Sans stage"],
                        "datasets":[{
                            "label":"Stages",
                            "data":[nbUtilisateurs -nbUtilisateursSansStage, nbUtilisateursSansStage],
                            "backgroundColor":["#28a745","#dc3545"]
                                }]
                    }
            });

        ctx = document.getElementById("chartjs-stage").getContext('2d');
        new Chart(ctx,
            {
                "type":"pie",
                "data":
                    {
                        "labels":["Stages validés", "Incomplets"],
                        "datasets":[{
                            "label":"Stages",
                            "data":[nbStages -nbStagesIncomplets, nbStagesIncomplets],
                            "backgroundColor":["#28a745","#fd7e14"]
                        }]
                    }
            });
    }

    function drawChartSituation(nbUtilisateurs, nbSituations, nbCommentaires, nbUtilisateursSansSituation, nbSituationsIncompletes) {
        var ctx = document.getElementById("chartjs-situationEtudiant").getContext('2d');
        new Chart(ctx,
            {
                "type":"pie",
                "data":
                    {
                        "labels":["Avec situation", "Sans situation"],
                        "datasets":[{
                            "label":"Stages",
                            "data":[nbUtilisateurs -nbUtilisateursSansSituation, nbUtilisateursSansSituation],
                            "backgroundColor":["#28a745","#dc3545"]
                        }]
                    }
            });

        ctx = document.getElementById("chartjs-situation").getContext('2d');
        new Chart(ctx,
            {
                "type":"pie",
                "data":
                    {
                        "labels":["Validées", "Validées avec commentaires", "Incomplètes"],
                        "datasets":[{
                            "label":"Situations",
                            "data":[nbSituations -nbSituationsIncompletes, nbCommentaires, nbSituationsIncompletes],
                            "backgroundColor":["#28a745", "#20c997", "#fd7e14"]
                        }]
                    }
            });
    }

    // Stages
    $.post("/app_dev.php/prof/stage/analyse", null,
        function (data) {
            // Successful requests get here
            // Update the page elements

            var oNbEtudiants = $('#nbEtudiants');
            oNbEtudiants.text(data.nbUtilisateurs);

            var oNbStages = $('#nbStages');
            oNbStages.text(data.nbStages);
            if (data.nbStages == 0) {
                oNbStages.attr("class", "badge badge-pill badge-danger");
            } else {
                drawChartStage(data.nbUtilisateurs, data.nbStages, data.nbUtilisateursSansStage, data.nbStagesIncomplets);
                $('#btnStageListe').show();
            }
            /*
            var oNbStages = $('#nbStages');
            oNbStages.text(data.nbStages);
            if (data.nbStages == 0) {
                oNbStages.attr("class", "badge badge-pill badge-danger");
            } else {
                drawChartStage(data.nbStages, data.nbUtilisateursSansStage, data.nbStagesIncomplets)
                $('#nbUtilisateursSansStage').text(data.nbUtilisateursSansStage);
                $('#nbStagesIncomplets').text(data.nbStagesIncomplets);
                $('#btnStageListe').show();
            }*/

            $('#loaderStages').hide();
        });

    // Situations
    $.post("/app_dev.php/prof/situation/analyse", null,
        function (data) {
            // Successful requests get here

            var oNbSituations = $('#nbSituations');
            oNbSituations.text(data.nbSituations);
            if (data.nbSituations == 0) {
                oNbSituations.attr("class", "badge badge-pill badge-danger");
            } else {
                drawChartSituation(data.nbUtilisateurs, data.nbSituations, data.nbCommentaires, data.nbUtilisateursSansSituation, data.nbSituationsIncompletes);
                $('#btnSituationListe').show();
            }


            /*var oNbSituations = $('#nbSituations');
            oNbSituations.text(data.nbSituations);
            if (data.nbSituations == 0) {
                oNbSituations.attr("class", "badge badge-pill badge-danger");
            } else {
                $('#nbCommentaires').text(data.nbCommentaires);
                $('#nbUtilisateursSansSituation').text(data.nbUtilisateursSansSituation);
                $('#nbSituationsIncompletes').text(data.nbSituationsIncompletes);
                $('#btnSituationListe').show();
            }*/
            // Update the page elements
            $('#loaderSituations').hide();
        });

});