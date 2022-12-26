class TextAnnotation{
  final String annoId;
  final DateTime created;
  final int creatorId;
  final String creatorName;
  final String annotationBody;
  final String selectedText;
  final int start;
  final int end;

  TextAnnotation(
      this.annoId,
      this.created,
      this.creatorId,
      this.creatorName,
      this.annotationBody,
      this.selectedText,
      this.start,
      this.end,
      );
}