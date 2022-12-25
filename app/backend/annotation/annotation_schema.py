from annotation.models import TextAnnotation, ImageAnnotation


def text_annotation_mapper(text_annotation: TextAnnotation)->dict:
    return {
        "@context" : "http://www.w3.org/ns/anno.jsonld",
        "body": [
            {
                "created" : text_annotation.date_created,
                "creator" : {
                    "id" : text_annotation.author_link,
                    "name": text_annotation.display_name
                },
                "modified" : text_annotation.date_modified,
                "purpose": text_annotation.purpose,
                "type" : "TextualBody",
                "value" : text_annotation.value
            },
        ],
        "id" : text_annotation.id,
        "target" : {
            "selector": [
                {
                    "exact" : text_annotation.exact,
                    "type" : "TextQuoteSelector"

                },
                {
                    "start": text_annotation.start,
                    "end": text_annotation.end,
                    "type": "TextPositionSelector",
                }
            ]
        },
        "type": "Annotation",
    }

def image_annotation_mapper(image_annotation: ImageAnnotation)->dict:
    return {
        "@context" : "http://www.w3.org/ns/anno.jsonld",
        "body": [
            {
                "created" : image_annotation.date_created,
                "creator" : {
                    "id" : image_annotation.author_link,
                    "name": image_annotation.display_name
                },
                "modified" : image_annotation.date_modified,
                "purpose": image_annotation.purpose,
                "type" : "TextualBody",
                "value" : image_annotation.value
            },
        ],
        "id" : image_annotation.id,
        "target" : {
            "selector": {
                    "conformsTo": "http://www.w3.org/TR/media-frags/",
                    "type": "FragmentSelector",
                    "value" : image_annotation.pixels,
                },
            "source": image_annotation.photo_url
        },
        "type": "Annotation",
    }