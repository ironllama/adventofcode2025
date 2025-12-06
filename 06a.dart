import 'utils.dart';
import "dart:io";

void main() async {
  // final lines = await readLines('06.test');
  final List<String> lines = await readLines('06.in');

  final List<String> rLines = lines.reversed.toList();

  int total = 0;

  final List<String> opers = [];
  final List<int> allNums = [];
  bool firstLine = true;

  for (final String line in rLines) {
    final List<String> tokens = line.trim().split(RegExp(r'\s+'));
    if (firstLine) {
      for (String tok in tokens) {
        opers.add(tok.trim());
        allNums.add(0);
      }
      firstLine = false;
      // print("OPERS: $opers");
    }
    else {
      for (int i = 0; i < tokens.length; i++) {
        final int newNum = int.parse(tokens[i].trim());
        if (opers[i] == '*') {
          if (allNums[i] == 0) allNums[i] = newNum;
          else allNums[i] *= newNum;
        }
        else allNums[i] += newNum;
      }
      // print("ALLNUMS: $allNums");
    }
  }

  for (final int num in allNums) total += num;

  print("TOT: $total");
}