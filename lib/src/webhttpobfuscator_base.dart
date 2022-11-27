// TODO: Put public facing types in this file.

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:webhttpobfuscator/connector/connector.dart';
import 'package:webhttpobfuscator/connector/obfuscator_response.dart';

class HttpObfuscatorClient with DioMixin {
  final String _obfuscatorServerUrl;
  final Function(String) _payloadEncryptor;
  final Function(String) _payloadDecryptor;

  final BaseOptions baseOptions;
  HttpObfuscatorClient(this._obfuscatorServerUrl, this._payloadEncryptor, this._payloadDecryptor, this.baseOptions);

  String _convertRequestToJson(String url, String requestMethod, Map<String, dynamic> headers, dynamic payload) {
    final Map<String, dynamic> data = {
      "method" : requestMethod,
      "url" : url,
      "headers" : headers,
      "payload" : payload
    };
    return jsonEncode(data);
  }

  @override
  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {



    return Response(requestOptions: RequestOptions(path: path));
  }
}