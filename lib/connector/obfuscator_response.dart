import 'package:dio/dio.dart';

class ObfuscatorResponse {
  final int _responseCode;
  final String _body;
  final Map<String, String> _headers;

  ObfuscatorResponse.fromJson(Map<String, dynamic> json) : _responseCode = json["code"], _body = json["body"], _headers = json["headers"];

  Headers get headers =>
      Headers.fromMap(
          _headers.map(
                  (key, value) => MapEntry(key, List<String>.from([value])))); // bit of a hack

  String get body => _body;

  int get responseCode => _responseCode;
}