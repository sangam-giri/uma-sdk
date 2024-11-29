import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class SHA256 {
  SHA256._();
  static String encrypt(String inputString) {
    // Create a SHA-256 hasher
    final sha256 = crypto.sha256;
    // Convert the input string to a list of bytes
    final bytes = utf8.encode(inputString);
    // Calculate the hash and return it as a hexadecimal string
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  static bool compare(
      {required String inputString, required String hashValue}) {
    if (encrypt(inputString) == hashValue) {
      return true;
    } else {
      return false;
    }
  }
}
