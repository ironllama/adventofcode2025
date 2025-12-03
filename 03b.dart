import 'utils.dart';

int highestDigitPos(String s, int minSize) {
  int maxPos = s.length - minSize;
  // print("MAXPOS: $maxPos");
  for (int i = 9; i > 0; i--) {
    final int posNum = s.indexOf(i.toString());
    // print("A: $s $i $s[$posNum]");

    if (posNum == -1 || posNum > maxPos) continue;

    return posNum;
  }

  return -1;
}

void main() async {
  // final lines = await readLines('03.test');
  final lines = await readLines('03.in');

  int total = 0;
  int findDigits = 12;

  for (final line in lines) {
    if (line.isEmpty || line.length < findDigits) continue;

    // Convert list of chars to list of nums
    final List<int> lineNums = line.split('')
        .map((s) => int.parse(s))
        .toList();

    int highest = 0;
    String linePiece = line;
    String soFar = "";

    if (linePiece.length < findDigits) {
      print("NOPE");
      break;
    }

    // int firstPos = highestDigitPos(linePiece, 2);
    // if (firstPos == -1) {
    //   print("PROBLEMS! firstPos is -1 [$linePiece]");
    //   break;
    // }
    // soFar += linePiece[firstPos];
    // linePiece = line.substring(firstPos + 1);

    // int secondPos = highestDigitPos(linePiece, 1);
    // if (secondPos == -1) {
    //   print("PROBLEMS! firstPos is -1 [$linePiece]");
    //   break;
    // }
    // soFar += linePiece[secondPos];
    // linePiece = line.substring(secondPos + 1);

    for (int i = findDigits; i > 0; i--) {
      int currPos = highestDigitPos(linePiece, i);
      if (currPos == -1) {
        print("PROBLEMS! currPos is -1 [$linePiece]");
        break;
      }
      soFar += linePiece[currPos];
      linePiece = linePiece.substring(currPos + 1);
    }

    // print("SO FAR: $soFar");
    final maxVal = int.parse(soFar);
    if (maxVal > highest) highest = maxVal;

    // print("LINE: $line $highest");
    total += highest;
  }

  print("TOT: $total");
}
