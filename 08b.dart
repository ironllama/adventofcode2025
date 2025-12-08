import 'utils.dart';
import "dart:io";
import 'dart:math';
// import 'package:collection/collection.dart';

void main() async {
  // final List<String> lines = await readLines('08.test');
  // final int maxConns = 29;
  final List<String> lines = await readLines('08.in');
  // final int maxConns = 6247;

  final List<List<int>> boxes = lines.map((s) => s.split(",").map(int.parse).toList()).toList();
  final List<List<int>> distances = [];
  // final PriorityQueue<List<int>> distances = (a, b) => a[2].compareTo(b[2]);  // Thought about it, thought about it, dropped it.
  final List<Set<int>> circuits = [];

  int total = 0;

  double distance (List<int> a, List<int> b) {
    int diffX = (b[0] - a[0]);
    int diffY = (b[1] - a[1]);
    int diffZ = (b[2] - a[2]);
    int sumSq = (diffX * diffX) + (diffY * diffY) + (diffZ * diffZ);
    return sqrt(sumSq);
  }

  // print("GETTING DISTANCES...");
  for (int i = 0; i < boxes.length; i++) {
    // print("$i of ${boxes.length}");
    for (int k = i + 1; k < boxes.length; k++) {
      int currDist = (distance(boxes[i], boxes[k]) * 100).toInt();

    // Trying to be cute, but optimizing only a list of the minimum number of distances.
    // But all the list management and repeated sorting made this SSSSLLLOOOWWWWW.
    // if (distances.length < maxConns || currDist < distances[distances.length - 1][2]) {
    //   if (distances.length < maxConns) distances.add([i, k, currDist]);
    //   else distances[distances.length - 1] = [i, k, currDist];
    //   distances.sort((a, b) => a[2].compareTo(b[2]));
    // }

      distances.add([i, k, currDist]);
    }
  }

  distances.sort((a, b) => a[2].compareTo(b[2]));
  // print("DIST:");
  // for (final a in distances) print(a);

  // print("DISTANCES DONE. CONNECTING...");
  for (int i = 0; i < distances.length; i++) {
    int a = distances[i][0];
    int b = distances[i][1];
    int foundA = -1;
    int foundB = -1;

    // We don't know which circuit past boxes were added to, so we have to check both A and B for every existing circuit
    for (int k = 0; k < circuits.length; k++) {  // Check A
      if (circuits[k].contains(a)) {
        circuits[k].add(b);
        foundA = k;
      }
    }

    for (int k = 0; k < circuits.length; k++) {  // Check B
      if (k == foundA) continue;  // Skip the circuits that already have A, so we don't duplicate B (though as a set, shouldn't matter)
      if (circuits[k].contains(b)) {
        circuits[k].add(a);
        foundB = k;
      }
    }

    if (foundA != -1 && foundB != -1) { // Both A and B found in differet circuits -- Need to combine!
      circuits[foundA] = {...circuits[foundA], ...circuits[foundB]};
      circuits.removeAt(foundB);
    }

    if (foundA == -1 && foundB == -1) {  // Neither A nor B found in any circuits
      circuits.add({distances[i][0], distances[i][1]});
    }

    if (circuits[0].length == boxes.length) {  // Detect the end, when there is just one giant circuit.
      // print("ENDS: $a ${boxes[a]} $b ${boxes[b]}");
      // print("ITERS: $i");
      total = boxes[a][0] * boxes[b][0];
      break;
    }
  }

  // print("CIRCUITS: ${boxes.length}");
  // for (Set<int> c in circuits) print(c.length);

  print("TOT: $total");
}