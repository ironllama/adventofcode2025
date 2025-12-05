import 'utils.dart';
import "dart:io";

void main() async {
  // final lines = await readLines('05.test');
  final lines = await readLines('05.in');

  int total = 0;
  var ranges = [];
  bool gettingRange = true;

  allLines: for (final line in lines) {
    if (line.isEmpty) {
      if (gettingRange) {
        gettingRange = false;
        continue;
      }
      else break;
    }

    if (gettingRange) {
      var pairs = line.split("-");
      ranges.add([int.parse(pairs[0]), int.parse(pairs[1])]);
    }
    else {
      int test = int.parse(line);

      // var goodNum = false;
      for (final range in ranges) {
        if (test >= range[0] && test <= range[1]) {
          // goodNum = true;
          total += 1;
          continue allLines;
        }
      }
    }
  }

  print("TOT: $total");
}