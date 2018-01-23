
<?php

//en dur pour rattraper le coup : les n° activités communes à ajouter dans le tableau
$actsisr="(35,36,40,41,42)";
$activiteSLAM="(26,27)";
// $req="select code, left(libelle,lngutile) as libelle from port_typologie order by 1";
$req="select * from typologie";
$typologie=$this->mysql->execSQLRes($req);

//$req='select idParcours from port_groupe G, port_etudiant E where G.num=E.numGroupe and E.num=118';
$req = "select numParcours from utilisateur where login = 'test.v2'";
$res=$this->mysql->execSQLRes($req);
$idParcours=2; // SLAM

//récupère TOUS les processus
//$req="select id, nomenclature, libelle from port_processus order by 1";
$req="select * from processus";

$tabProcessus=$this->mysql->execSQLRes($req);
/*
P1 Production de services
P2 Fourniture de services
P3 Conception et maintenance de solutions d’infrastru...
P4 Conception et maintenance de solutions applicative...
P5 Gestion du patrimoine informatique
 */
//efface libelle processus pour compétences communes ajoutées (colonne trop étroite)
if ($idParcours==1)
    $tabProcessus[3]["libelle"]="";
if ($idParcours==2)
    $tabProcessus[2]["libelle"]="";


$nbProcessus=count($tabProcessus);// tjs 5 processus
$nbActivites=0;  // compte nb total activités pour ces 5 processus = nb colonnes ds tableau synthèse
$tabActivites=array();  //tableau d'id d'activités à constuire
for($i=0 ; $i<$nbProcessus ; $i++)
{
    //pour chaque processus récupère les activités
    if ($idParcours==1 && $i==3)
    {
        //sisr et processus 4
        $req="select A.id as id, A.nomenclature as nomenclature, left(A.libelle,lngutile) as libelle, 1 as idEpreuve
        from activite A
        where A.id in ".$actsisr." order by 1";
    }
    else
    {
        if ($idParcours==2 && $i==2)
        {
            //SLAM et processus 3
            $req="select A.id as id, A.nomenclature as nomenclature, left(A.libelle,lngutile) as libelle, 1 as idEpreuve
            from Activite A
            where A.id in ".$activiteSLAM." order by 1";
            // $activiteSLAM="(26,27)";
        }
        else
        {
            $req="select A.id as id, A.nomenclature as nomenclature, left(A.libelle,lngutile) as libelle, idEpreuve
            from activite A, domaine D, evalue E
            where A.id=E.idActivite and E.idParcours=".$idParcours." and
            A.idDomaine=D.id and D.idProcessus=".$tabProcessus[$i]["id"]." order by 1";
        }
    }
    $tba=$this->mysql->execSQLRes($req);
    $nbtba=count($tba); // nombre d'activités par processus
    for ($j=0; $j<$nbtba ; $j++) //pour chaque activité du processus
        $tabActivites[]=$tba[$j]["id"];//croissant

    $nbActivites+=$nbtba;
    $tabProcessus[$i]["act"]=$tba;
}

/*
 *
POUR LES RESEAU
select A.id as id, A.nomenclature as nomenclature, left(A.libelle,lngutile) as libelle, idEpreuve
from activite A, domaine D, evalue E
where A.id=E.idActivite and
A.idDomaine=D.id and E.idParcours=1
UNION
select A.id as id, A.nomenclature as nomenclature, left(A.libelle,lngutile) as libelle, 1 as idEpreuve
from activite A
WHERE A.id in (35,36,40,41,42)

ORDER BY 1
 * ******
 *
 POUR LES DEV
select A.id as id, A.nomenclature as nomenclature, left(A.libelle,lngutile) as libelle, idEpreuve
from activite A, domaine D, evalue E
where A.id=E.idActivite and
A.idDomaine=D.id and E.idParcours=2
UNION
select A.id as id, A.nomenclature as nomenclature, left(A.libelle,lngutile) as libelle, 1 as idEpreuve
from activite A
where A.id in (26,27)
ORDER BY 1
 */


$tabProcessus["nba"]=$nbActivites;
$tabProcessus["nbp"]=$nbProcessus;

$req="select code, libelle from typesource order by 1";
$res=$this->mysql->execSQLRes($req);
//récupère les situations et /stage1 /stage2
for ($src=0 ; $src<count($res) ; $src++){
    $req="select ref, libcourt, datedebut, datefin from port_situation, port_source
          where codeSource=code and numEtudiant=118  and valide='O'
          and  codeTypesource=".$res[$src]["code"]." order by 1";
    $tbsit=$this->mysql->execSQLRes($req);

    for ($i=0;$i<count($tbsit); $i++){
      $req="select distinct idActivite from port_activitecitee
            where refSituation=".$tbsit[$i]["ref"]." order by 1";//m'énerve, j'y arrive pas avec des left join...
      $tbida=$this->mysql->execSQLRes($req);
      $nbtbida=count($tbida);

      $tabActivitesc=array();
      //remplit le tableau avec de X
      for ($j=0 ; $j<count($tabActivites); $j++) {
        $k=0; //pointe sur $tbida
        $v=$tabActivites[$j];
        while ($k<$nbtbida && $tbida[$k]["idActivite"]!=$v) $k++;
        if ($k<$nbtbida) $tabActivitesc[$j]="X"; else $tabActivitesc[$j]=" ";
      }
      $tbsit[$i]["act"]=$tabActivitesc;
      $req="select codeTypologie from port_esttypo
          where refSituation=".$tbsit[$i]["ref"]." order by 1";
      // select code from situationtypo
      //  where refSituation=".$tbsit[$i]["ref"]." order by 1";
      $tbtypo=$this->mysql->execSQLRes($req);
      $arraytypo=array();
      $nbtbtypo= count($tbtypo);

      // Parcours de la table Typologie
      for ($l=0 ; $l<count($typologie) ; $l++) {
        $k=0;
        $v=$typologie[$l]["code"];//normalement 1..4,  mais...
        while ($k<$nbtbtypo && $tbtypo[$k]["codeTypologie"]!=$v) $k++;
        if ($k<$nbtbtypo) $arraytypo[$l]="X"; else $arraytypo[$l]=" ";
      }
      $tbsit[$i]["typo"]=$arraytypo;
    }

    $tb["sit"][$src]=$tbsit;
    $tb["libsit"][$src]=$res[$src]["libelle"];
}
$tb["et"]=$tabProcessus;
$tb["ident"]=$this->getEtudiant($numeleve);
//exit;
return $tb;