class TextAnnotation{
  final DateTime created;
  final int creatorId;
  final String creatorName;
  final String annotationBody;
  final String annotationId;
  final String selectedText;
  final int start;
  final int end;

  TextAnnotation(
      this.created,
      this.creatorId,
      this.creatorName,
      this.annotationBody,
      this.annotationId,
      this.selectedText,
      this.start,
      this.end,
      );
}