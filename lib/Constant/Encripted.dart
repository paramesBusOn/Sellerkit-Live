// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
class EncryptData {
//for AES Algorithms

  static Encrypted? encrypted;
  static var decrypted;

  String encryptAES(plainText) {
    final key = Key.fromUtf8('32358357407475453235835740747545');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: 'PKCS7'));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    print("Encrypted: ${encrypted!.base64}");

    return encrypted!.base64.toString();
  }

//   String decryptAES(Encrypted  plainText) {
//     final key = Key.fromUtf8('32358357407475453235835740747545');
//     final iv = IV.fromLength(16);
//     // // final test="";
//     // // plainText=test
//     final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
//     String decrypted = encrypter.decrypt(encrypted!, iv: iv);
//     print("Decrypted: $decrypted");

//     return decrypted.toString();
//   }
// testmethod(){
//   final key = encrypt.Key.fromUtf8("32358357407475453235835740747545");
// final iv = encrypt.IV.fromLength(16); 
// final encrypter = encrypt.Encrypter(encrypt.AES(key));

// String encryptedToken = '2M5EPWxd7zUvznKC10sJvIFnvlH2eOL9y8g4uyx/FXiMY4DCvdj5JvKreZsKVVVOqiWhcbaqTMAhXJULbSf+OLUQKrXqRAX7rR52NaVR1T4vUsKiLcTDbum80p4BVrupcbu88n+yYXgYHXb0dThGtOAn/pJAw1E/ubQZvLPoRxtwY9R7GUMx3JiU/BelWTfL2GzwJVIhaquZo9JziAxGpA=='; // Replace '...' with the actual encrypted token.

// try {
//   final decrypted = encrypter.decrypt64(encryptedToken, iv: iv);
//   print('Decrypted Token: $decrypted');
// } catch (e) {
//   print('Error decrypting token: $e');
// }
// }


 String decrypt(String encrypted) {
//  encrypted = '0bOQ7Q04V8F0v5PPAZc7QxAA30GKJYrPlBLFqZAPDJLHKePwU8M/CpI2XfsnohIWJur4BHI98TTJE7uf5ffLhFqTf+wZqTNCBaaQaqqvNY/q8C081VkWGzho7dnNOUFVhvazPURm/eFOCMUnrA+heYzAQ6PQ4Edn9dHgFNgxUa26gk2OpNY9vJ7afxYYblBUDLBsSmcPUWQfWTbv5pSWHA=='; // Replace '...' with the actual encrypted token.

  final key =
      Key.fromUtf8("32358357407475453235835740747545"); //hardcode combination of 16 character
  final iv =
      IV.fromLength(16); //hardcode combination of 16 character

  final encrypter = Encrypter(AES(key, mode: AESMode.ecb,padding :'PKCS7',));
  Encrypted enBase64 = Encrypted.from64(encrypted);
  final decrypted = encrypter.decrypt(enBase64, iv: iv);
  print('Decrypted Token: ${decrypted}');  
  
  return decrypted.toString();
} 
}
