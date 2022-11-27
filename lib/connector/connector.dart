import 'package:web_socket_channel/web_socket_channel.dart';

class Connector {
  static Future<String> send(String obfuscatorServerUrl, String jsonPayload, {Duration timeout = const Duration(seconds: 20)}) async {
    final channel = WebSocketChannel.connect(Uri.parse(obfuscatorServerUrl));
    channel.stream.timeout(timeout);

    channel.sink.add(jsonPayload);
    return await channel.stream.last; // return response from server
  }
}