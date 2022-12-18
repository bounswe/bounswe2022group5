from annotation.models import TextAnnotation


def annotation_mapper(text_annotation: TextAnnotation)->dict:
    return {
        "@context" : "http://www.w3.org/ns/anno.jsonld",
        "id" : text_annotation.id,
        "type" : "Annotation",
        "creator": {
          "id" : text_annotation.author.id,
          "type" : "Person",
          "email" : text_annotation.author.email
        },
        "created" : text_annotation.date
        "body" : [
            {
            "type" : "TextualBody",
            "text": text_annotation.body,
            "format" : "text/plain",
            "language": "en"
            },
        ],
        "target" : {
            {
                "source": text_annotation.source_id,
                "selector": {
                    "type" : "TextPositionSelector",
                    "start" : text_annotation.start,
                    "end" : text_annotation.end
                }
            }
        }
    }