import 'package:web_http_obfuscator/web_http_obfuscator.dart';

void main() async {
  final client = HttpObfuscatorClient(
      "ws://localhost:9268",
          (data) => data,
          (data) => data
  );
  final response = await client.get("https://google.com/");
  print("Response: ${response.data}");
}
