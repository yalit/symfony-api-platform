<?php

declare(strict_types=1);

namespace App\Entity\DTO;

use App\Entity\Article;

class ArticleOutputDataTransformer implements \ApiPlatform\Core\DataTransformer\DataTransformerInterface
{

    /**
     * @param Article $object
     */
    public function transform($object, string $to, array $context = [])
    {
        $output = new ArticleOutput();
        $output->zeTitle = $object->getTitle();

        return $output;
    }

    /**
     * @inheritDoc
     */
    public function supportsTransformation($data, string $to, array $context = []): bool
    {
        return ArticleOutput::class === $to && $data instanceof Article;
    }
}
