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
    
    /*

        //en mm :
        $margeg=10; //marge gauche
        $hvt=15; //hauteur texte
        $hvp=15; //hauteur ligne processus
        $hv=60;//hauteur texte �crit verticalement;
        $hvs=15;//hauteur pour une situ, fixe puisque seul libcourt<=64car
        $margeinterne=4;//marge entre 4 col. oblig et les 57 autres ( 1 <= $margeinterne <= 6)
        $lg=6; // prevoir 6 mm par colonne
        $lgoblig=6;//largeur colonnes pour themes obligatoires (tjs 4)
        $offset=7;
        $mgs=32;//largeur colonne de gauche pour situs (libcourt)
        //en points :
        $potitre=14;
        $potexte=12;
        $pocroix=10;
        $posousigne=10;
        $polibelle=5;
        //niveau de gris
        $grisclairfond=200;//gris clair pour fond cellules E6
        $grisclairtrait=200;
        $police="Arial";
     */

    private $syntheseBuilder;

    public function __construct(SyntheseBuilder $syntheseBuilder)
    {
        parent::__construct('L','mm','A3');
        $this->syntheseBuilder = $syntheseBuilder;
    }

    public function generateSynthese()
    {

        $this->SetTitle("Tableau de synthèse");
        $this->SetAuthor('BTS SIO');


        //en mm :
        $margeg=10; //marge gauche
        $hvt=15; //hauteur texte
        $hvp=15; //hauteur ligne processus
        $hv=60;//hauteur texte �crit verticalement;
        $hvs=15;//hauteur pour une situ, fixe puisque seul libcourt<=64car
        $margeinterne=4;//marge entre 4 col. oblig et les 57 autres ( 1 <= $margeinterne <= 6)
        $lg=6; // prevoir 6 mm par colonne
        $lgoblig=6;//largeur colonnes pour themes obligatoires (tjs 4)
        $offset=7;
        $mgs=32;//largeur colonne de gauche pour situs (libcourt)
        //en points :
        $potitre=14;
        $potexte=12;
        $pocroix=10;
        $posousigne=10;
        $polibelle=5;
        //niveau de gris
        $grisclairfond=200;//gris clair pour fond cellules E6
        $grisclairtrait=200;
        $police="Arial";

        $this->AddPage();
        $this->SetFont("Arial",'B',14);
        $txt="BTS SERVICES INFORMATIQUES AUX ORGANISATIONS - TABLEAU DE SYNTHESE";
        $this->Cell(0,$hvt,$txt,0,1,"C");
        $this->SetFont("Arial",'B',12);
        $user = $this->syntheseBuilder->getUtilisateur();
        $txt="Nom et prénom du candidat : ".$user->getNom()." ".$user->getPrenom();
        $this->Cell(60, $hvt,"",0,0);
        $this->Cell(160,$hvt,$txt,0,0);
        $txt="Parcours : ".$user->getNumparcours()->getNomenclature();
        $this->Cell(60,$hvt,$txt,0,0);
        $txt="Numéro du candidat : ".$user->getNumexamen();
        $this->Cell(0,$hvt,$txt,0,1);

        $this->SetFont("Arial",'B',5);
        $this->Ln(5);


        // Situation obligatoire
        $this->Cell(4*$lgoblig,$hvp,"Situation obligatoire",1,0,"C");
        $this->Cell($mgs+$margeinterne,$hvp,"",0,0);

        // processus
        foreach ($this->syntheseBuilder->getProcessus() as $processus) {
            $largeur = $lg * $processus["count"];
            $this->Cell($largeur,$hvp,$processus["libelle"],1,0,"C");
        }

        $x0=$offset;
        $x=$x0+$lgoblig/2;;
        $y0=$this->getY();
        $y1=$y0+$hv;//hauteur texte à 90°
        $this->SetFillColor($grisclairfond);

        foreach ($this->syntheseBuilder->getTypologies() as $typologie) {
            $this->TourneTexte(90,$x+$lg/2,$y1,"  ".$typologie->getLibelle());
            $this->SetXY($x,$y0);
            $this->Cell($lg,$hv,"",1,0);//hauteur case verticale
            $x+=$lg;
        }

        $x0=$mgs+4*$lgoblig+$margeinterne+$offset;
        $x=$x0+$lg/2;;
        $y0=$this->getY();
        $y1=$y0+$hv;

        $nombreActivites = 0;
        foreach ($this->syntheseBuilder->getActivitesDomaine() as $activitesDomaine) {
            $nombreActivites++;

            $this->SetXY($x,$y0);
            //epreuve E6=3 (E4=1 ; E5=2)
            if ($activitesDomaine->getIdepreuve()->getId() == 3) {
                $this->Cell($lg,$hv,"",1,0,"C",true);
                $epreuveE6[]=true;
            } else {
                $this->Cell($lg,$hv,"",1,0,"C",false);
                $epreuveE6[]=false;
            }
            $this->SetXY($x,$y0);
            $this->TourneTexte(90,$x+$lg/2,$y1,"  ".$activitesDomaine->getIdactivite()->getNomenclature() ."  ". $activitesDomaine->getIdactivite()->getLibelle());
            $this->Cell($lg,$hv,"",1,0);//hauteur case verticale
            $x+=$lg;
        }

        $this->Ln($hv);

        $typeSituation = array ("SITUATIONS VÉCUES EN FORMATION", "SITUATIONS VÉCUES EN STAGE DE PREMIÈRE ANNÉE", "SITUATIONS VÉCUES EN STAGE DE DEUXIÈME ANNÉE");
        $countTypeSituation = 3;
        
        // Affichage d'une ligne vide

        //affichage cellules en filigranne
        $this->SetDrawColor($grisclairtrait);
        for ($i=0; $i<4;$i++)
            $this->Cell($lgoblig,$hvs,"","LR",0); //4 cellules claires à gauche
        $this->Cell($mgs+$margeinterne,$hvs,"",0,0);
        $ysrc = $this->getY();
        $xsrc = $this->getX();

        for ($i=0; $i<$nombreActivites ; $i++)
            $this->Cell($lg,$hvs,"","LR",0);//que gauche et droite en clair
        $this->SetXY($xsrc,$ysrc);
        $this->SetFont($police,'B',$potexte);
        $this->Cell(0, $hvs, $typeSituation[0],0,1,"C");
        $this->SetDrawColor(0); //noir

        // LES SITUATIONS
        foreach ($this->syntheseBuilder->getSituations() as $situation)
        {
            $this->SetFont($police,'B',$pocroix);
            foreach ($this->syntheseBuilder->getTypologies() as $typology) {
                if ($situation->isCodePresent($typology->getCode()))
                    $caractere = "X";
                else
                    $caractere = " ";
                $this->Cell($lgoblig,$hvs,$caractere,1,0);
            }
            $this->Cell($margeinterne,$hvs,"",0,0);
            $this->SetFont($police,'B',$polibelle);
            $x0=$this->getX();
            $y0=$this->getY();


            $dates = $situation->getDatedebut()->format("d/m/Y") . ' - '.$situation->getDatedebut()->format("d/m/Y");
            $this->MultiCell($mgs,5,$situation->getLibelle() ."\n". $dates,0);
            $this->setXY($x0,$y0);
            $this->Cell($mgs,$hvs,"",1,0);
            //affichage des X pour les activites citées
            $this->SetFont($police,'B',$pocroix);

            foreach ($situation->getArraySituationActiviteCites() as $situationActiviteCites)
            {
                $this->Cell($lg,$hvs," ".$situationActiviteCites["present"],1,0,"C", $situationActiviteCites["e6"]);
            }
            $this->Ln($hvs);
        }


        return $this->output();
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