<?php

declare(strict_types=1);

namespace App\Entity\DTO;

use App\Entity\Article;

final class ArticleOutput
{
    public string $zeTitle;
    public string $zeContent;
    public string $zeCreationDate;
    public string $zeUpdatedDate;

    public static function createFromArticle(Article $article) : self
    {
        $articleOutput = new self();

        $articleOutput->zeTitle = $article->getTitle();

    }
}
