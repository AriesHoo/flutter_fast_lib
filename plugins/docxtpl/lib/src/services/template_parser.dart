/// parse the simple jinja2-like template from element tag text
/// replaceStart...replaceEnd
List<String> templateParse({
  required String text,
  String replaceStart = '{{',
  String replaceEnd = '}}',
}) {
  List<String> fields = [];

  final RegExp re = RegExp(
    '$replaceStart\\w*$replaceEnd',
    caseSensitive: true,
    multiLine: true,
  );

  Iterable<Match> matches = re.allMatches(text);

  if (matches.isEmpty) {
    return fields;
  }

// matches found
  else {
    for (var match in matches) {
      int group = match.groupCount;
      String field = match.group(group)!;

      // remove templating braces
      var firstChunk = field.replaceAll(replaceStart, '').trim();
      var secChunk = firstChunk.replaceAll(replaceEnd, '').trim();

      fields.add(secChunk);
    }
  }

  return fields;
}
