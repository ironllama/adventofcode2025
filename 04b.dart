import 'utils.dart';
import "dart:io";

void main() async {
  // List lines = await readLines('04.test');
  List lines = await readLines('04.in');

  int total = 0;

  final neighbors = [[-1, -1],[0, -1], [1, -1], [-1, 0],[1,0],[-1,1],[0,1],[1,1]]; // [x, y]

  bool removed = true;
  while (removed) {
    removed = false;
    List tempLines = [...lines];

    for (int row = 0; row < lines.length; row++) {
      for (int col = 0; col < lines[0].length; col++) {
          if (lines[row][col] != '@') {
            // stdout.write(tempLines[row][col]);
            // tempLines[row][col] = lines[row][col];
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
            tempLines[row] = tempLines[row].substring(0, col) + '.' + tempLines[row].substring(col + 1);
            // stdout.write('x');
            removed = true;
            total += 1;
          }
          // else stdout.write(tempLines[row][col]);
      }
      // print("");
    }

    lines = tempLines;

    // for (final row in lines) {
    //   print(row);
    // }
    // print("");
  }

  print("TOT: $total");
}