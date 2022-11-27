import 'package:dio/dio.dart';
import 'package:webhttpobfuscator/webhttpobfuscator.dart';

void main() {
  HttpObfuscatorClient(
      "ws://localhost:8080",
          (data) => data,
          (data) => data,
        BaseOptions()
        )
      .get("https://google.com/test.php",
      queryParameters: {"test2" : "test1", "testtttt": "2314124"},
      options: Options(receiveTimeout: 123));
}
