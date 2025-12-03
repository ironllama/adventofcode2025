import 'dart:io';
import 'dart:convert';
import 'dart:math';

Future<List<String>> readLines(String path) async {
  final file = File(path);
  final lines = <String>[];

  final stream = file.openRead()
    .transform(utf8.decoder)
    .transform(const LineSplitter());

  await for (final line in stream) {
    lines.add(line);
  }

  return lines;
}

void main() async {
//   final lines = await readLines('03.test');
  final lines = await readLines('03.in');

  int total = 0;

  for (final line in lines) {
    if (line.isEmpty) continue;

    int highest = 0;
    for (int i = 9; i > 0; i--) {
        final int posNum = line.indexOf(i.toString());
        // print("A: $line $i $line[$posNum]");

        if (posNum == -1 || posNum == (line.length - 1)) continue;

        final List<int> afterPos = line.substring(posNum + 1)
            .split('')
            .map((s) => int.parse(s))
            .toList();

        final int highestValue = afterPos.reduce(max);
        final maxVal = int.parse(line[posNum] + highestValue.toString());

        if (maxVal > highest) highest = maxVal;
    }

    // print("LINE: $line $highest");
    total += highest;
  }

  print("TOT: $total");
}
