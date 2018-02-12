<?php
/**
 * Created by PhpStorm.
 * User: epsi
 * Date: 09/02/18
 * Time: 12:30
 */

namespace AppBundle\Form;


use Symfony\Component\HttpFoundation\File\File;
use Symfony\Component\HttpFoundation\Response;

use PhpOffice\PhpWord\PhpWord;
use PhpOffice\PhpWord\TemplateProcessor;

class WordResponse extends Response
{
    /**
     * WordResponse constructor.
     * @param string $name The name of the word file
     * @param TemplateProcessor $word
     */
    public function __construct(TemplateProcessor $templateProcessor, $fileName)
    {
        parent::__construct();

        //Set headers.
        $this->headers->set("Content-Description", 'File Transfer');
        $this->headers->set("Content-Disposition", 'attachment; filename="' . $fileName . '"');
        $this->headers->set("Content-Type", 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');
        $this->headers->set("Content-Transfer-Encoding", 'binary');
        $this->headers->set("Cache-Control", 'must-revalidate, post-check=0, pre-check=0');
        $this->headers->set("Expires", '0');
        $this->sendHeaders();
        $tempDocumentFilename = $templateProcessor->save();


        $this->setContent(file_get_contents($tempDocumentFilename));
    }

}