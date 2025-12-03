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

void main() async {
  // final lines = await readLines('01.test');
  final lines = await readLines('01.in');
  //  print(lines);

  int dial = 50;
  int total = 0;

  for (final line in lines) {
    if (line.isEmpty) continue;

    final dir = line[0];
    final amtStr = line.length > 1 ? line.substring(1) : "";

    // Try converting the amtStr of the line into a amt
    final amt = int.tryParse(amtStr);
    if (amt == null) {
      print("First: $dir | amtStr is not a valid amt: '$amtStr'");
      continue;
    }

    // int added = 0;
    // if (dir == "L") {
    //   if (amt > dial && dial != 0) {
    //     total += (amt ~/ 100) + 1;
    //     added = (amt ~/ 100) + 1;
    //     // if (dial == 0) total -= 1;
    //   }
    //   dial = (dial - amt) % 100;
    // }
    // else {
    //   if (amt > (100-dial) && dial != 0) {
    //     total += (amt ~/ 100) + 1;
    //     added = (amt ~/ 100) + 1;
    //     // if (dial == 0) total -= 1;
    //   }
    //   dial = (dial + amt) % 100;
    // }

    // if (dial <= 0) dial += 100;
    // if (dial == 100) dial = 0;

    // print("DIR: $dir\tAMT: $amt\tDIAL: $dial\tADD: $added");

    // if (dial == 0) total += 1;

    for (int i = 0; i < amt; i++) {
      if (dir == "L") dial -= 1;
      else dial += 1;

      if (dial > 99) dial = 0;
      else if (dial < 0) dial = 99;

      if (dial == 0) total += 1;
    }
  }

  print("TOT: $total");
}

// 5462 -- Too low
// 6492 -- Too high