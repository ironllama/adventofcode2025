import 'dart:io';
import 'dart:convert';

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
  // final lines = await readLines('02.test');
  final lines = await readLines('02.in');

  int total = 0;
  var invalids = <int>{};

  for (final line in lines) {
    if (line.isEmpty) continue;

    for (String pair in line.split(',')) {

      final ids = pair.trim().split('-');

      final firstId = int.parse(ids[0]);
      final secondId = int.parse(ids[1]);
      // print("FIRST: $firstId SECOND: $secondId");

      for (int i = firstId; i <= secondId; i++) {
        final iStr = i.toString();

        for (var k = 2; k <= iStr.length; k++) {
          if (iStr.length % k == 0) {
            // print("\t$i DIV BY $k");
            int checkSize = iStr.length ~/ k;
            int totalParts = iStr.length ~/ checkSize;
            String invalid = iStr.substring(0, checkSize);
            String invalidAcc = invalid;

            bool repeating = true;
            for (var m = 1; m < totalParts; m++) {
              int start = m * checkSize;
              String testStr = iStr.substring(start, start + checkSize);
              // print("CHECK: $i $invalid $testStr");
              if (invalid != testStr) {
                repeating = false;
                break;
              }
              invalidAcc += invalid;
            }

            if (repeating) invalids.add(int.parse(invalidAcc));
          }
        }
      }
    }
  }

  // print("ALL: $invalids");

  total = invalids.fold(0, (prev, element) => prev + element);
  print("TOT: $total");
}

// 6013240443 -- Too low
