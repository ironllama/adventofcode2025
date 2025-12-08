import 'utils.dart';
import "dart:io";

void main() async {
  // final List<String> lines = await readLines('07.test');
  final List<String> lines = await readLines('07.in');

  final List<String> newLines = [lines[0]];
  int total = 0;

  for (int r = 1; r < lines.length; r++) {
    String newLine = "";
    bool split = false;
    for (int c = 0; c < lines[0].length; c++) {
      if (split) {
        split = false;
        continue;
      }

      if (lines[r][c] == '.') {
        if (newLines[r-1][c] == '|' || newLines[r-1][c] == 'S') newLine += '|';
        else newLine += '.';
      }
      else {
        if (newLines[r-1][c] == '|') {
          newLine = newLine.substring(0, newLine.length-1) + '|^|';
          split = true;
          total += 1;
        }
        else newLine += '^';
      }
    }

    newLines.add(newLine);
  }

  // print("NEWLINES:");
  // for (String line in newLines) print(line);

  print("TOT: $total");
}