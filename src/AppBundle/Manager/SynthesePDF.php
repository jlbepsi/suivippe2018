<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 25/01/18
 * Time: 14:36
 */

namespace AppBundle\Manager;


class SynthesePDF extends \FPDF
{

    private $angle=0;
    private $internalX;
    private $internalY;

    private $syntheseBuilder;

    public function __construct(SyntheseBuilder $syntheseBuilder)
    {
        parent::__construct('L','mm','A3');
        $this->syntheseBuilder = $syntheseBuilder;
    }

    // Pour les accents
    protected function _escape($s)
    {
        $newStr = $s;
        // Escape special characters
        if(strpos($s,'(')!==false || strpos($s,')')!==false || strpos($s,'\\')!==false || strpos($s,"\r")!==false)
            $newStr =  str_replace(array('\\','(',')',"\r"), array('\\\\','\\(','\\)','\\r'), $s);

        return utf8_decode($newStr);
    }

    public function generateSynthese()
    {
        $this->SetTitle("TableauSynthese", true);
        $this->SetAuthor('BTS SIO');


        //en mm :
        //$margeg=10; //marge gauche
        $hauteurTexte=15; //hauteur texte
        $hauteurLigneProcessus=15; //hauteur ligne processus
        $hauteurTexteVertical=60;//hauteur texte écrit verticalement;
        $hauteurLigneSituation=15;//hauteur pour une situ, fixe puisque seul libcourt<=64car
        $margeinterne=4;//marge entre 4 col. oblig et les 57 autres ( 1 <= $margeinterne <= 6)
        $largeurColonne=6; // prevoir 6 mm par colonne
        $largeurColonneThemeObligatoire=6;//largeur colonnes pour themes obligatoires (tjs 4)
        $offset=7;
        $largeurColonneSituationLibelle=32;//largeur colonne de gauche pour situs (libcourt)
        //en points :
        $potitre=14;
        $largeurPointTexte=12;
        $largeurPointCroix=10;
        $largeurPointSousigne=10;
        $largeurPointLibelle=5;
        //niveau de gris
        $grisclairfond=200;//gris clair pour fond cellules E6
        $grisclairtrait=200;
        $police="Arial";

        $this->AddPage();
        $this->SetFont("Arial",'B',14);
        $txt="BTS SERVICES INFORMATIQUES AUX ORGANISATIONS - TABLEAU DE SYNTHESE";
        $this->Cell(0,$hauteurTexte,$txt,0,1,"C");
        $this->SetFont("Arial",'B',12);
        $user = $this->syntheseBuilder->getUtilisateur();
        $txt="Nom et prénom du candidat : ".$user->getNom()." ".$user->getPrenom();
        $this->Cell(60, $hauteurTexte,"",0,0);
        $this->Cell(160,$hauteurTexte,$txt,0,0);
        $txt="Parcours : ".$user->getNumparcours()->getNomenclature();
        $this->Cell(60,$hauteurTexte,$txt,0,0);
        $txt="Numéro du candidat : ".($user->getNumexamen() > 0 ? $user->getNumexamen(): "");
        $this->Cell(0,$hauteurTexte,$txt,0,1);

        $this->SetFont("Arial",'B',5);
        $this->Ln(5);


        // Situation obligatoire
        $this->Cell(4*$largeurColonneThemeObligatoire,$hauteurLigneProcessus,"Situation obligatoire",1,0,"C");
        $this->Cell($largeurColonneSituationLibelle+$margeinterne,$hauteurLigneProcessus,"",0,0);

        // processus
        foreach ($this->syntheseBuilder->getProcessus() as $processus) {
            $largeur = $largeurColonne * $processus["count"];
            $length = strlen($processus["libelle"]);
            if ($length > $largeur -3)
                $texte = substr($processus["libelle"], 0, $largeur -3) . "...";
            else
                $texte = $processus["libelle"];
            $this->Cell($largeur,$hauteurLigneProcessus,$texte,1,0,"C");
        }

        $x0=$offset;
        $x=$x0+$largeurColonneThemeObligatoire/2;
        $y0=$this->getY() +15;
        $y1=$y0+$hauteurTexteVertical;//hauteur texte à 90°
        $this->SetFillColor($grisclairfond);

        foreach ($this->syntheseBuilder->getTypologies() as $typologie) {
            $this->TourneTexte(90,$x+$largeurColonne/2,$y1,"  ".$typologie->getLibelleCourt());
            $this->SetXY($x,$y0);
            $this->Cell($largeurColonne,$hauteurTexteVertical,"",1,0);//hauteur case verticale
            $x+=$largeurColonne;
        }

        $x0=$largeurColonneSituationLibelle+4*$largeurColonneThemeObligatoire+$margeinterne+$offset;
        $x=$x0+$largeurColonne/2;;
        $y0=$this->getY();
        $y1=$y0+$hauteurTexteVertical;

        $nombreActivites = 0;
        foreach ($this->syntheseBuilder->getActivitesDomaine() as $activitesDomaine) {
            $nombreActivites++;

            $this->SetXY($x,$y0);
            //epreuve E6=3 (E4=1 ; E5=2)
            if ($activitesDomaine->getIdepreuve()->getId() == 3) {
                $this->Cell($largeurColonne,$hauteurTexteVertical,"",1,0,"C",true);
            } else {
                $this->Cell($largeurColonne,$hauteurTexteVertical,"",1,0,"C",false);
            }
            $this->SetXY($x,$y0);
            $this->TourneTexte(90,$x+$largeurColonne/2,$y1,"  ".$activitesDomaine->getIdactivite()->getNomenclature() ."  ". $activitesDomaine->getIdactivite()->getLibelleCourt());
            $this->Cell($largeurColonne,$hauteurTexteVertical,"",1,0);//hauteur case verticale
            $x+=$largeurColonne;
        }

        $this->Ln($hauteurTexteVertical);

        $typeSituation = array ("SITUATIONS VÉCUES EN FORMATION", "SITUATIONS VÉCUES EN STAGE DE PREMIÈRE ANNÉE", "SITUATIONS VÉCUES EN STAGE DE DEUXIÈME ANNÉE");
        $countTypeSituation = 3;
        
        // Affichage d'une ligne vide

        //affichage cellules en filigranne
        $this->SetDrawColor($grisclairtrait);
        for ($i=0; $i<4;$i++)
            $this->Cell($largeurColonneThemeObligatoire,$hauteurLigneSituation,"","LR",0); //4 cellules claires à gauche
        $this->Cell($largeurColonneSituationLibelle+$margeinterne,$hauteurLigneSituation,"",0,0);

        for ($i=0; $i<$nombreActivites ; $i++)
            $this->Cell($largeurColonne,$hauteurLigneSituation,"","LR",0);//que gauche et droite en clair

        $this->showSitiationIntitule($typeSituation[0], $police, $largeurPointTexte, $hauteurLigneSituation);

        /*
         *
         * LES SITUATIONS
         *
         */
        foreach ($this->syntheseBuilder->getSituations() as $situation)
        {
            $this->SetFont($police,'B',$largeurPointCroix);
            foreach ($this->syntheseBuilder->getTypologies() as $typology) {
                if ($situation->isCodePresent($typology->getCode()))
                    $caractere = "X";
                else
                    $caractere = " ";
                $this->Cell($largeurColonneThemeObligatoire,$hauteurLigneSituation,$caractere,1,0);
            }
            $this->Cell($margeinterne,$hauteurLigneSituation,"",0,0);
            $this->SetFont($police,'B',$largeurPointLibelle);
            $x0=$this->getX();
            $y0=$this->getY();


            $dates = $situation->getDatedebut()->format("d/m/Y") . ' - '.$situation->getDatefin()->format("d/m/Y");
            $this->MultiCell($largeurColonneSituationLibelle,5,$situation->getLibelleCourt() ."\n". $dates,0);
            $this->setXY($x0,$y0);
            $this->Cell($largeurColonneSituationLibelle,$hauteurLigneSituation,"",1,0);
            //affichage des X pour les activites citées
            $this->SetFont($police,'B',$largeurPointCroix);

            foreach ($situation->getArraySituationActiviteCites() as $situationActiviteCites)
            {
                $this->Cell($largeurColonne,$hauteurLigneSituation," ".$situationActiviteCites["present"],1,0,"C", $situationActiviteCites["e6"]);
            }
            $this->Ln($hauteurLigneSituation);
        }


        /*
         *
         * LES STAGES
         *
         */
        for($cpt=1; $cpt < 3; $cpt++)
        {
            // année en cours
            $this->showSitiationIntitule($typeSituation[$cpt], $police, $largeurPointTexte, $hauteurLigneSituation);

            $tagesIntitules = $this->syntheseBuilder->getStagesIntitules($cpt);
            foreach ($tagesIntitules as $stageintitule) {

                $this->SetFont($police,'B',$largeurPointCroix);
                foreach ($this->syntheseBuilder->getTypologies() as $typology) {
                    /*if ($stageintitule->isCodePresent($typology->getCode()))
                        $caractere = "X";
                    else*/
                        $caractere = " ";
                    $this->Cell($largeurColonneThemeObligatoire,$hauteurLigneSituation,$caractere,1,0);
                }
                $this->Cell($margeinterne,$hauteurLigneSituation,"",0,0);
                $this->SetFont($police,'B',$largeurPointLibelle);
                $x0=$this->getX();
                $y0=$this->getY();


                $dates = $stageintitule->getIdstage()->getDatedebut()->format("d/m/Y") . ' - '.$stageintitule->getIdstage()->getDatefin()->format("d/m/Y");
                $this->MultiCell($largeurColonneSituationLibelle,5,$stageintitule->getIdstage()->getLibellecourt() ."\n". $dates,0);
                $this->setXY($x0,$y0);
                $this->Cell($largeurColonneSituationLibelle,$hauteurLigneSituation,"",1,0);
                //affichage des X pour les activites citées
                $this->SetFont($police,'B',$largeurPointCroix);

                foreach ($stageintitule->getArrayStageActiviteCites() as $stageActiviteCites)
                {
                    $this->Cell($largeurColonne,$hauteurLigneSituation," ".$stageActiviteCites["present"],1,0,"C", $stageActiviteCites["e6"]);
                }
                $this->Ln($hauteurLigneSituation);
            }
        }
        /*
         *
         * LES STAGES
         *
         *
        foreach ($this->syntheseBuilder->getStagesIntitules() as $stageintitule) {

            $this->SetFont($police,'B',$largeurPointCroix);
            foreach ($this->syntheseBuilder->getTypologies() as $typology) {
                 if ($stageintitule->isCodePresent($typology->getCode()))
                    $caractere = "X";
                else
                    $caractere = " ";
                $this->Cell($largeurColonneThemeObligatoire,$hauteurLigneSituation,$caractere,1,0);
            }
            $this->Cell($margeinterne,$hauteurLigneSituation,"",0,0);
            $this->SetFont($police,'B',$largeurPointLibelle);
            $x0=$this->getX();
            $y0=$this->getY();


            $dates = $stageintitule->getIdstage()->getDatedebut()->format("d/m/Y") . ' - '.$stageintitule->getIdstage()->getDatefin()->format("d/m/Y");
            $this->MultiCell($largeurColonneSituationLibelle,5,$stageintitule->getIdstage()->getLibellecourt() ."\n". $dates,0);
            $this->setXY($x0,$y0);
            $this->Cell($largeurColonneSituationLibelle,$hauteurLigneSituation,"",1,0);
            //affichage des X pour les activites citées
            $this->SetFont($police,'B',$largeurPointCroix);

            foreach ($situation->getArraySituationActiviteCites() as $situationActiviteCites)
            {
                $this->Cell($largeurColonne,$hauteurLigneSituation," ".$situationActiviteCites["present"],1,0,"C", $situationActiviteCites["e6"]);
            }
            $this->Ln($hauteurLigneSituation);
        }*/
        $this->Ln(10);

        //gestion bas de page : soussigné...
        $candidat = ($user->getSexe() == 2 ? "le candidat" : "la candidate");
        $this->Ln(10);
        $texte = "Je soussignée, BOMPARD Jean-Luc, formateur au centre de formation EPSI certifie que ". $candidat ." a bien effectué en formation les activités et missions présentées dans ce tableau.";
        $this->SetFont($police,'B',$largeurPointSousigne);
        $this->Cell(0,$hauteurTexte,$texte,0,0);

        $this->Ln(20);
        $texte = "Je soussignée, MALEZIEUX Sylvie, représentante de l'organisation EPSI certifie que ". $candidat ." a bien effectué en stage les activités et missions présentées dans ce tableau.";
        $this->Cell(0,$hauteurTexte,$texte,0,1);


        return $this->output("I", $user->getNom().$user->getPrenom(). "_TableauSynthese.pdf");
    }

    private function showSitiationIntitule($texte, $police, $largeurPointTexte, $hauteurLigneSituation)
    {
        $ysrc = $this->getY();

        $this->SetXY(0,$ysrc);
        $this->SetFont($police,'B',$largeurPointTexte);
        $this->Cell(0, $hauteurLigneSituation, $texte,0,1,"C");
        $this->SetDrawColor(0); //noir
    }

    function CellRadio($wt,$wr,$h,$txt,$typ,$border,$valide,$por)
    {
        $b1="";
        $b2="";
        $ln=0;
        if ($typ=="B") $this->SetGras($por); else $this->SetPasGras($por);
        if (strstr($border,"L")) {$b1.="L";}
        if (strstr($border,"T")) {$b1.="T"; $b2.="T";}
        if (strstr($border,"B")) {$b1.="B"; $b2.="B";}
        if (strstr($border,"R")) { $b2.="R"; $ln=1;}
        if ($valide=="O") $v="l"; else $v="m";
        $this->Cell($wt,$h,$txt,$b1,0,"R");
        $this->SetFont('zapfdingbats','',10);
        $this->Cell($wr,$h,$v,$b2,$ln,"L");
        $this->SetGras($por, false);
    }

    function Puce($numero,$position,$taille, $police)
    {
        $puces="*+-";
        $txt=substr($puces,$numero,1);
        //$txt="+";
        $this->SetFont('zapfdingbats','',16);
        $this->Cell($position,7,$txt,0,0,"R");
        $this->SetFont($police,'',$taille);
    }

    function SetGras($p, $isSet = true){
        $this->SetFont('Arial',($isSet ? 'B' : ''),$p);
    }

    function Header()
    {
        //$this->Image("images/logoFiligrane.png",120,10,70);
        //$this->Image("images/bandeau.png",30,7,15);
    }

    function Footer()
    {
        //Pied de page
        $this->SetY(-15);
        $this->SetFont('Arial','I',8);
        $this->SetTextColor(128);
        $this->Cell(0,10,'Page '.$this->PageNo(),0,0,'C');
    }

    function Rotate($angle,$x=-1,$y=-1){
        if($x==-1)
            $x=$this->internalX;
        if($y==-1)
            $y=$this->internalY;
        if($this->angle!=0)
            $this->_out('Q');
        $this->angle=$angle;
        if($angle!=0)
        {
            $angle*=M_PI/180;
            $c=cos($angle);
            $s=sin($angle);
            $cx=$x*$this->k;
            $cy=($this->h-$y)*$this->k;
            $this->_out(sprintf('q %.5F %.5F %.5F %.5F %.2F %.2F cm 1 0 0 1 %.2F %.2F cm',$c,$s,-$s,$c,$cx,$cy,-$cx,-$cy));
        }
    }

    function TourneTexte($angle=90,$x,$y,$txt){
        $this->Rotate($angle,$x,$y);
        $this->Text($x,$y,$txt);
        $this->Rotate(0);
    }

}