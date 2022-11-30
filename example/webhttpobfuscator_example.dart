import 'package:web_http_obfuscator/web_http_obfuscator.dart';

void main() async {
  final client = HttpObfuscatorClient(
      "ws://localhost:9268",
          (data) => data,
          (data) => data
  );
  final response = await client.post("https://google.com/", data: {"my":"form"});
  print("Response: ${response.data}");
}
