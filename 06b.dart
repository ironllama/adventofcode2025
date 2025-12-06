import 'utils.dart';
import "dart:io";

void main() async {
  // final List<String> lines = await readLines('06.test');
  final List<String> lines = await readLines('06.in');

  int total = 0;

  final List<List<dynamic>> opers = [];
  bool firstLine = true;

  String lastLine = lines[lines.length - 1];
  bool firstOper = true;
  int currLen = 0;
  for (int i = 0; i < lastLine.length; i++) {
    if (lastLine[i] != ' ') {
      if (!firstOper) opers[opers.length - 1][1] = currLen;
      else firstOper = false;
      currLen = 0;
      opers.add([lastLine[i], currLen, 0]);
    }
    else currLen += 1;
    // print("CHAR: ${lastLine[i]}");
  }
  opers[opers.length - 1][1] = currLen + 1;  // Update last item
  // print("OPERS: $opers");

  int offset = 0;
  for (int i = 0; i < opers.length; i++) {
    String oper = opers[i][0];
    int size = opers[i][1];

    int operNum = 0;
    for (int k = size - 1; k >= 0; k--) {
      String newNum = "";
      for (int m = 0; m < lines.length - 1; m++) newNum += lines[m][offset + k];
      // print("NEWNUM: $newNum");
      int intNum = int.parse(newNum);

      if (oper == '*') {
        if (operNum == 0) operNum = intNum;
        else operNum *= intNum;
      }
      else operNum += intNum;
    }

    offset += size + 1;
    total += operNum;
  }

  print("TOT: $total");
}