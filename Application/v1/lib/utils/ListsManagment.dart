import 'dart:math';

List<T> randomizeList<T>(
  List<T> list, {
  int scale = 1, // 1 to 5
}) {
  assert(scale >= 1 && scale <= 5, 'Scale must be between 1 and 5');

  final random = Random();
  final result = List<T>.from(list);

  // Number of swaps increases with scale
  final int swaps = (result.length * scale).clamp(1, result.length * 5);

  for (int i = 0; i < swaps; i++) {
    final int index1 = random.nextInt(result.length);
    final int index2 = random.nextInt(result.length);

    // Swap elements
    final temp = result[index1];
    result[index1] = result[index2];
    result[index2] = temp;
  }

  return result;
}
