<?php
/**
 * Created by PhpStorm.
 * User: epsi
 * Date: 05/03/18
 * Time: 16:58
 */

namespace AppBundle\Form;


use PhpOffice\PhpWord\TemplateProcessor;

class TemplateProcessorImage extends TemplateProcessor
{

    /**
     * resource id
     * @var int
     */
    private $temporaryRessourceId = 1;

    /**
     * Content of ressources file (in XML format) of the temporary document
     * @var string
     */
    private $temporaryWordRelDocumentPart;

    /**
     * Content of ContentType file(in XML format) or the temporary document
     * @var string
     */
    private $temporaryContentType;
    private $arrayImageContentType = array(
        'png' => 'image/png',
        "jpg" => 'image/jpeg'
    );


    /**
     *
     * GESTION DES IMAGES
     * https://raw.githubusercontent.com/ptournem/PHPWord/master/src/PhpWord/TemplateProcessor.php
     *
     */

    /**
     * Add a file in a document
     * @param string $path
     * @param string $fileName
     * @return string  ressource id
     */
    public function addFile($path, $fileName) {
        $endRelDoc = "</Relationships>";
        // add file in the zip file
        $this->zipClass->addFromString('word/media/' . $fileName, file_get_contents($path));
        $id = 'rIdTemp' . $this->temporaryRessourceId++;

        // create the word resource
        $tmpRel = '<Relationship Id="#id#" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/#name#"/>';
        $tmpRel = str_replace('#id#', $id, $tmpRel);
        $tmpRel = str_replace('#name#', $fileName, $tmpRel);
        $tmpRel.= $endRelDoc;

        // add resource in the rel file
        $this->temporaryWordRelDocumentPart = str_replace($endRelDoc, $tmpRel, $this->temporaryWordRelDocumentPart);

        // return the image id in order to link with it when you create the image
        return $id;
    }

    /**
     *  Replace a var with an image
     * @param string $search
     * @param string $imgPath
     * @param string $imgName with the extension
     * @param int $width
     * @param int $height
     * @param string title
     * @return boolean
     */
    public function setImage($search, $imgPath, $imgName, $width = 400, $height = 400, $title = false) {
        // check path
        if (!file_exists($imgPath)) {
            return false;
        }

        $id = $this->addFile($imgPath, $imgName);
        $replace = ' <w:pict><v:shape id="tempShape_' . $id . '" type="#_x0000_t75" style="width:' . $width . '; height:' . $height . '"><v:imagedata r:id="' . $id . '" o:title="' . ( $title != false ? $title : $imgName ) . '"/></v:shape></w:pict>';

        $this->setValue($search, $replace);

        return true;
    }
}