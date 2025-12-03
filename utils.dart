import 'dart:io';
import 'dart:convert';

Future<List<String>> readLines(String path) async {
  final stream = File(path).openRead()
    .transform(utf8.decoder)
    .transform(const LineSplitter());

  final lines = <String>[];

  await for (final line in stream) lines.add(line);

  return lines;
}
