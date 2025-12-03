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

// bool hasRepeatingDigits(String s) {
//   final seen = <String>{};
//   for (var c in s.split('')) {
//     print("hasRepeating? $c $seen");
//     if (!seen.add(c)) return true;
//   }
//   return false;
// }

void main() async {
  // final lines = await readLines('02.test');
  final lines = await readLines('02.in');

  int total = 0;
  var invalids = <int>{};

  for (final line in lines) {
    if (line.isEmpty) continue;

    for (var pair in line.split(',')) {
      // print("CHECKING: $pair");

      final ids = pair.trim().split('-');
      // if (ids[0].length.isOdd && ids[0].length.isOdd) continue; // Both must be even length

      // final firstId = int.parse(ids[0]);
      // final secondId = int.parse(ids[1]);

      // // Check first ID
      // final firstHalf = ids[0].length ~/ 2;
      // var firstBeg = ids[0].substring(0, firstHalf);
      // final firstEnd = ids[0].substring(firstHalf);
      // if (firstBeg == "") firstBeg = "0";  // Edge case for single digits, when half results in a blank string, so it doesn't break the parse
      // var invalidId = int.parse(firstBeg + firstBeg);
      // // print("FIRST: $invalidId $firstId $secondId");
      // if (invalidId >= firstId && invalidId <= secondId) {
      //   invalids.add(invalidId);
      // }

      // // Check second ID
      // final secondHalf = ids[1].length ~/ 2;
      // var secondBeg = ids[1].substring(0, secondHalf);
      // final secondEnd = ids[1].substring(secondHalf);
      // if (secondBeg == "") secondBeg = "0";   // Edge case for single digits, when half results in a blank string, so it doesn't break the parse
      // invalidId = int.parse(secondBeg + secondBeg);
      // // print("second: $invalidId $firstId $secondId");
      // if (invalidId >= firstId && invalidId <= secondId) {
      //   invalids.add(invalidId);
      // }


      // Brute force
      final firstId = int.parse(ids[0]);
      final secondId = int.parse(ids[1]);

      for (var i = firstId; i <= secondId; i++) {
        final iStr = i.toString();
        final half = iStr.length ~/ 2;
        var beg = iStr.substring(0, half);
        final end = iStr.substring(half);

        if (beg == end) invalids.add(int.parse(beg+end));
      }
    }
  }

  // print("ALL: $invalids");

  total = invalids.fold(0, (prev, element) => prev + element);
  print("TOT: $total");
}

// 6013240443 -- Too low
