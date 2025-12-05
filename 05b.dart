import 'utils.dart';
import "dart:io";

void main() async {
  // final lines = await readLines('05.test');
  final lines = await readLines('05.in');

  int total = 0;

  // Brute-force. Takes too long!
  // var goodNums = <int>{};
  // for (final line in lines) {
  //   if (line.isEmpty) break;

  //   var pairs = line.split("-");
  //   // ranges.add([int.parse(pairs[0]), int.parse(pairs[1])]);
  //   for (var num = int.parse(pairs[0]); num <= int.parse(pairs[1]); num++) goodNums.add(num);
  // }

  List<List<int>> fromRanges = [];
  for (final line in lines) {
    if (line.isEmpty) break;
    List<int> pairs = line.split("-").map(int.parse).toList();
    fromRanges.add(pairs);
  }

  bool consolidating = true;
  while (consolidating) {
    List<List<int>> toRanges = [];

    for (final fRange in fromRanges) {
      bool inRange = false;
      for (final tRange in toRanges) {
        if (fRange[0] >= tRange[0] && fRange[0] <= tRange[1] && fRange[1] > tRange[1]) {
          tRange[1] = fRange[1];  // start is inside, end is outside
          inRange = true;
        }
        else if (fRange[0] < tRange[0] && fRange[1] >= tRange[0] && fRange[1] <= tRange[1]) {
          tRange[0] = fRange[0];  // start is outside, end is inside
          inRange = true;
        }
        else if (fRange[0] < tRange[0] && fRange[1] > tRange[1]) {
          tRange[0] = fRange[0];  // start is outside, end is outside
          tRange[1] = fRange[1];
          inRange = true;
        }
        else if (fRange[0] >= tRange[0] && fRange[1] <= tRange[1]) {
          inRange = true;  // start is inside, end is inside
        }
      }

      if (!inRange) toRanges.add(fRange);
    }

    if (fromRanges.length == toRanges.length) consolidating = false;
    fromRanges = toRanges;
    fromRanges.sort((a, b) => a[0].compareTo(b[0]));
  }

  // print("fromRanges: $fromRanges");
  for (final range in fromRanges) {
    total += range[1] - range[0] + 1;
    // print(range);
  }

  print("TOT: $total");
}
