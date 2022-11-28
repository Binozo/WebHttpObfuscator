// TODO: Put public facing types in this file.

import 'dart:convert';

import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:web_http_obfuscator/connector/connector.dart';
import 'package:web_http_obfuscator/connector/obfuscator_response.dart';

class HttpObfuscatorClient with DioMixin {
  final String _obfuscatorServerUrl;
  final Function(String) _payloadEncryptor;
  final Function(String) _payloadDecryptor;

  final BaseOptions baseOptions;
  HttpObfuscatorClient(
      this._obfuscatorServerUrl,
      this._payloadEncryptor,
      this._payloadDecryptor,
      {BaseOptions? options}) : baseOptions = options ?? BaseOptions() {
    this.options = baseOptions;
    this.httpClientAdapter = BrowserHttpClientAdapter();
  }

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

    if(queryParameters != null) {
      for(int i = 0; i < queryParameters.entries.length; i++) {
        final key = queryParameters.keys.elementAt(i);
        final value = queryParameters.values.elementAt(i);
        if(i == 0) {
          String prefix = "?";
          if(path.contains(prefix)) {
            prefix = "&";
          }
          path += "$prefix$key=$value";
        } else {
          path += "&$key=$value";
        }
      }
    }

    final requestJson = _convertRequestToJson(path, "GET", baseOptions.headers, null);

    final encrypted = _payloadEncryptor(requestJson);
    assert(encrypted is String);

    final String result = await Connector.send(_obfuscatorServerUrl, requestJson);

    // Decrypt result

    final decrypted = _payloadDecryptor(result);
    assert(decrypted is String);

    // Convert to Object
    final response = ObfuscatorResponse.fromJson(jsonDecode(decrypted));

    return Response(
        requestOptions: RequestOptions(path: path),
        data: response.body as T?,
        headers: response.headers,
        statusCode: response.responseCode);
  }

  @override
  Future<Response<T>> getUri<T>(Uri uri,
      {Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) {

    return get(uri.toString(),
        queryParameters: uri.queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }
}