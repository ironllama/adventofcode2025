import 'utils.dart';
import "dart:io";

void main() async {
  // final List<String> lines = await readLines('07.test');
  final List<String> lines = await readLines('07.in');

  int total = 0;

  final List<List<int>> newNums = List.generate(lines.length, (i) => List.filled(lines[i].length, 0));
  // print("NEWNUMS INIT:"); for (final num in newNums) print(num);

  int startPos = lines[0].indexOf('S');

  // Brute force by following paths recursively. Too slow!
  // int fallDown (List<String> lines, int r, int c) {
  //   if (r >= lines.length) return 1;
  
  // //   print("CHECK: $r $c -- ${lines[r][c]}");
  //   if (lines[r][c] == '^') return fallDown(lines, r+2, c-1) + fallDown(lines, r+2, c+1);
  //   else return fallDown(lines, r+2, c);
  // }
  // total = fallDown(lines, 2, startPos);

  // Use an array of totals and add up as each row is processed.
  newNums[0][startPos] = 1;
  for (int r = 0; r < newNums.length; r++) {
    // print("LINE: ${newNums[r]}");
    for (int c = 0; c < newNums[0].length; c++) {
      if (newNums[r][c] != 0) {
        int currNum = newNums[r][c];  // Get current num and pass it down.

        if (r+2 >= lines.length) break;

        if (lines[r+2][c] == '^') {  // Add num to left and right
          newNums[r+2][c-1] += currNum;
          newNums[r+2][c+1] += currNum;
        }
        else newNums[r+2][c] += currNum;
      }
    }
  }

  total = newNums[newNums.length-2].fold(0, (acc, v) => acc + v);

  print("TOT: $total");
}