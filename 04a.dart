import 'utils.dart';
import "dart:io";

void main() async {
  // final lines = await readLines('04.test');
  final lines = await readLines('04.in');

  int total = 0;

  final neighbors = [[-1, -1],[0, -1], [1, -1], [-1, 0],[1,0],[-1,1],[0,1],[1,1]]; // [x, y]

  for (int row = 0; row < lines.length; row++) {
    for (int col = 0; col < lines[0].length; col++) {
        if (lines[row][col] != '@') {
          // stdout.write(lines[row][col]);
          continue;
        }

        int numPaper = 0;
        bool canGet = true;
        for (final test in neighbors) {
            if (row == 0 && test[1] < 0) continue;
            if (col == 0 && test[0] < 0) continue;
            if (row == (lines.length - 1) && test[1] > 0) continue;
            if (col == (lines[0].length - 1) && test[0] > 0) continue;
            // print("TESTING: $row $col $test");

            if (lines[row + test[1]][col + test[0]] == '@') numPaper += 1;

            if (numPaper >= 4) {
                canGet = false;
                break;
            }
        }

        if (canGet) {
          // stdout.write('x');
          total += 1;
        }
        // else stdout.write(lines[row][col]);
    }
    // print("");
  }

  print("TOT: $total");
}