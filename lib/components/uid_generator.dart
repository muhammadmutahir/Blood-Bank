import 'dart:math';

class UidGenerator {
  static String createID() {
    String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String numbers = "0123456789";
    final random = Random();
    String randString =
        List.generate(13, (index) => chars[random.nextInt(chars.length)])
            .join();
    int v1 = int.parse(
        List.generate(3, (index) => numbers[random.nextInt(numbers.length)])
            .join());
    int v2 = int.parse(
        List.generate(3, (index) => numbers[random.nextInt(numbers.length)])
            .join());
    int resultedInt = v1 * v2 + random.nextInt(23);
    String combinedString = randString + resultedInt.toString();
    List<String> combinedCharList = combinedString.split('');
    combinedCharList.shuffle(random);
    String uid = combinedCharList.join();
    return uid;
  }
}
