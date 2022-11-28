import 'package:dio/dio.dart';

class ObfuscatorResponse {
  final int _responseCode;
  final dynamic _body;
  final Map<String, dynamic> _headers;

  ObfuscatorResponse.fromJson(Map<String, dynamic> json) : _responseCode = json["code"], _body = json["body"], _headers = Map<String, dynamic>.from(json["headers"]);

  Headers get headers =>
      Headers.fromMap(
          _headers.map(
                  (key, value) => MapEntry(key, List<String>.from([...value])))); // bit of a hack

  dynamic get body => _body;

  int get responseCode => _responseCode;
}